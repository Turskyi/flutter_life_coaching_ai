import 'dart:async';
import 'dart:core';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/application_services/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:lifecoach/di/injector.dart' as di;
import 'package:lifecoach/di/injector.dart';
import 'package:lifecoach/infrastructure/data_sources/local/local_data_source.dart';
import 'package:lifecoach/localization/localization_delelegate_getter.dart'
    as localization;
import 'package:lifecoach/ui/app/app.dart';
import 'package:lifecoach/ui/feedback/feedback_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [main] is the ultimate detail — the lowest-level policy.
/// It is the initial entry point of the system.
/// Nothing, other than the operating system, depends on it.
/// Here we should [injectDependencies] by a dependency injection framework.
/// The [main] is a dirty low-level module in the outermost circle of the onion
/// architecture.
/// Think of [main] as a plugin to the [App] — a plugin that sets
/// up the initial conditions and configurations, gathers all the outside
/// resources, and then hands control over to the high-level policy of the
/// [App].
/// When [main] is released, it has utterly no effect on any of the other
/// components in the system. They don’t know about [main], and they don’t care
/// when it changes.
Future<void> main() async {
  // Ensure that the Flutter engine is initialized, to avoid errors with
  // `SharedPreferences` dependencies initialization.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection and wait for `SharedPreferences`.
  await di.injectDependencies();

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  final LocalDataSource localDataSource = LocalDataSource(preferences);

  final LocalizationDelegate localizationDelegate = await localization
      .getLocalizationDelegate();

  final AuthenticationRepository authenticationRepository =
      GetIt.instance<AuthenticationRepository>();
  final AuthenticationBloc authenticationBloc =
      GetIt.instance<AuthenticationBloc>();

  runApp(
    LocalizedApp(
      localizationDelegate,
      BetterFeedback(
        feedbackBuilder:
            (
              BuildContext _,
              OnSubmit onSubmit,
              ScrollController? scrollController,
            ) {
              return FeedbackForm(
                onSubmit: onSubmit,
                scrollController: scrollController,
              );
            },
        child: App(
          authenticationRepository: authenticationRepository,
          authenticationBloc: authenticationBloc,
          localDataSource: localDataSource,
        ),
      ),
    ),
  );
}
