import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:lifecoach/infrastructure/data_sources/remote/resend/feedback_email_remote_data_source.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:url_launcher/url_launcher.dart';

part 'goals_event.dart';
part 'goals_state.dart';

@injectable
class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  GoalsBloc(
    this._goalsRepository,
    this._authenticationBloc,
    this._feedbackEmailRemoteDataSource,
  ) : super(const GoalsInitial()) {
    on<LoadGoals>(_onLoadGoals);

    on<BugReportPressedEvent>(_onBugReportPressedEvent);

    on<CreateGoalEvent>(_onCreateGoal);

    on<UpdateGoalEvent>(_onUpdateGoal);

    on<DeleteGoalEvent>(_onDeleteGoal);

    on<SubmitFeedbackEvent>(_onSubmitFeedbackEvent);

    on<ClosingFeedbackEvent>(_onClosingFeedbackEvent);

    on<ErrorEvent>(_onErrorEvent);
  }

  FutureOr<void> _onDeleteGoal(
    DeleteGoalEvent event,
    Emitter<GoalsState> emit,
  ) async {
    final Goal goal = event.goal;
    emit(GoalDeleting(goalId: goal.id, goals: state.goals));
    // Get the user ID from the authentication bloc.
    final String userId = _authenticationBloc.state.user.id;

    final MessageResponse response = await _goalsRepository.delete(
      goal.copyWith(userId: userId),
    );
    // Remove the goal from the existing list of goals.
    final List<Goal> updatedGoals = List<Goal>.from(state.goals)..remove(goal);
    // Emit the new state with the updated list of goals.
    emit(GoalDeleted(message: response.message, goals: updatedGoals));
  }

  FutureOr<void> _onUpdateGoal(
    UpdateGoalEvent event,
    Emitter<GoalsState> emit,
  ) async {
    await _handleCreateOrUpdateGoal(emitter: emit, event: event);
  }

  FutureOr<void> _onCreateGoal(
    CreateGoalEvent event,
    Emitter<GoalsState> emit,
  ) async {
    await _handleCreateOrUpdateGoal(emitter: emit, event: event);
  }

  final GoalsRepository _goalsRepository;
  final AuthenticationBloc _authenticationBloc;
  final FeedbackEmailRemoteDataSource _feedbackEmailRemoteDataSource;

  FutureOr<void> _onLoadGoals(LoadGoals _, Emitter<GoalsState> emit) async {
    // Access the user ID from the AuthenticationBloc's state.
    final String userId = _authenticationBloc.state.user.id;

    if (userId.isEmpty) {
      emit(
        const UnauthenticatedGoalsAccessState(errorText: 'User ID not found'),
      );
      return;
    }
    // Fetch goals using the user ID.
    try {
      final List<Goal> goals = await _goalsRepository.getGoals(userId: userId);
      emit(GoalsLoaded(goals: goals));
    } catch (error) {
      emit(GoalsError(errorText: error.toString()));
    }
  }

  Future<void> _handleCreateOrUpdateGoal({
    required Emitter<GoalsState> emitter,
    required GoalsEvent event,
  }) async {
    final List<Goal> goals = List<Goal>.from(state.goals);
    if (event is CreateGoalEvent) {
      emitter(CreatingGoal(goals: state.goals));
      // Get the user ID from the authentication bloc.
      final String userId = _authenticationBloc.state.user.id;
      // Create the new goal using the repository.
      final Goal newGoal = await _goalsRepository.create(
        Goal(title: event.title, content: event.content, userId: userId),
      );

      // Add the new goal to the existing list of goals.
      goals.add(newGoal);
    } else if (event is UpdateGoalEvent) {
      final Goal goal = event.goal;
      emitter(UpdatingGoal(goalId: goal.id, goals: state.goals));
      final Goal updatedGoal = await _goalsRepository.update(goal);

      // Update the goal in the existing list of goals.
      final int index = goals.indexWhere(
        (Goal existingGoal) => existingGoal.id == updatedGoal.id,
      );
      if (index != -1) {
        goals[index] = updatedGoal;
      }
    }

    // Emit the new state with the updated list of goals.
    emitter(GoalSubmitted(goals: goals));
  }

  FutureOr<void> _onBugReportPressedEvent(
    BugReportPressedEvent _,
    Emitter<GoalsState> emit,
  ) {
    emit(FeedbackState(goals: state.goals, language: state.language));
  }

  FutureOr<void> _onSubmitFeedbackEvent(
    SubmitFeedbackEvent event,
    Emitter<GoalsState> emit,
  ) async {
    if (state is! FeedbackSent) {
      final UserFeedback feedback = event.feedback;
      try {
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();

        final String platform = kIsWeb
            ? translate('web')
            : switch (defaultTargetPlatform) {
                TargetPlatform.android => translate('android'),
                TargetPlatform.iOS => translate('ios'),
                TargetPlatform.macOS => translate('macos'),
                TargetPlatform.windows => translate('windows'),
                TargetPlatform.linux => translate('linux'),
                _ => translate('unknown'),
              };

        final Map<String, Object?>? extra = feedback.extra;
        final Object? rating = extra?[constants.ratingProperty];
        final Object? type = extra?[constants.feedbackTypeProperty];
        final Object? screenSize = extra?[constants.screenSizeProperty];
        final String feedbackText = feedback.text;

        // `extra?[constants.feedbackTextProperty]` is usually same as
        // `feedback.text`.
        final Object feedbackExtraText =
            extra?[constants.feedbackTextProperty] ?? feedbackText;

        final bool isFeedbackType = type is FeedbackType;
        final bool isFeedbackRating = rating is FeedbackRating;

        // Construct the feedback text with details from `extra'.
        final StringBuffer feedbackBody = StringBuffer()
          ..writeln(
            '${isFeedbackType ? translate('feedback.type') : ''}:'
            ' ${isFeedbackType ? type.value : ''}',
          )
          ..writeln(feedbackText.isEmpty ? feedbackExtraText : feedbackText)
          ..writeln(
            '${isFeedbackRating ? translate('feedback.rating') : ''}'
            '${isFeedbackRating ? ':' : ''}'
            ' ${isFeedbackRating ? rating.value : ''}',
          )
          ..writeln()
          ..writeln('${translate('app_id')}: ${packageInfo.packageName}')
          ..writeln('${translate('app_version')}: ${packageInfo.version}')
          ..writeln('${translate('build_number')}: ${packageInfo.buildNumber}')
          ..writeln()
          ..writeln('${translate('platform')}: $platform')
          ..write(
            screenSize == null
                ? ''
                : '${translate('screen_size')}: $screenSize\n',
          );

        if (event.submissionType.isAutomatic) {
          await _feedbackEmailRemoteDataSource.sendFeedbackEmail(
            subject:
                '${translate('feedback.app_feedback')}: ${packageInfo.appName}',
            body: feedbackBody.toString(),
          );
        } else if (kIsWeb || Platform.isMacOS) {
          final Uri emailLaunchUri = Uri(
            scheme: constants.mailToScheme,
            path: constants.supportEmail,
            queryParameters: <String, Object?>{
              constants.subjectParameter:
                  '${translate('feedback.app_feedback')}: '
                  '${packageInfo.appName}',
              constants.bodyParameter: feedbackBody.toString(),
            },
          );
          try {
            if (await canLaunchUrl(emailLaunchUri)) {
              await launchUrl(emailLaunchUri);
              debugPrint(
                'Feedback email launched successfully via url_launcher.',
              );
            } else {
              throw const EmailLaunchException('error.launch_email_failed');
            }
          } catch (urlLauncherError, urlLauncherStackTrace) {
            final String urlLauncherErrorMessage =
                'Error launching email via url_launcher: $urlLauncherError';
            debugPrint(
              '$urlLauncherErrorMessage\nStackTrace: $urlLauncherStackTrace',
            );

            final String errorMessage = translate('error.launch_email_failed');
            emit(GoalsError(errorText: errorMessage, language: state.language));
          }
        } else {
          final String screenshotFilePath = await _writeImageToStorage(
            feedback.screenshot,
          );
          final Email email = Email(
            body: feedbackBody.toString(),
            subject:
                '${translate('feedback.app_feedback')}: '
                '${packageInfo.appName}',
            recipients: <String>[constants.supportEmail],
            attachmentPaths: <String>[screenshotFilePath],
          );
          try {
            await FlutterEmailSender.send(email);
          } catch (error, stackTrace) {
            debugPrint(
              'Error in $runtimeType sending email: $error.\n'
              'Stacktrace: $stackTrace',
            );
            add(
              ErrorEvent(translate('error.unexpected_error_sending_feedback')),
            );
          }
        }

        emit(FeedbackSent(goals: state.goals, language: state.language));
      } catch (error, stackTrace) {
        debugPrint(
          'Error in $runtimeType preparing feedback: $error.\n'
          'Stacktrace: $stackTrace',
        );
        add(ErrorEvent(translate('error.unexpected_error_preparing_feedback')));
      }
      emit(GoalsLoaded(goals: state.goals, language: state.language));
    }
  }

  Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await path.getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }

  FutureOr<void> _onClosingFeedbackEvent(
    ClosingFeedbackEvent _,
    Emitter<GoalsState> emit,
  ) {
    emit(GoalsLoaded(goals: state.goals, language: state.language));
  }

  FutureOr<void> _onErrorEvent(ErrorEvent event, Emitter<GoalsState> emit) {
    emit(
      GoalsError(
        errorText: event.error,
        goals: state.goals,
        language: state.language,
      ),
    );
  }
}
