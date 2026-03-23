import 'package:injectable/injectable.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:resend/resend.dart';

@lazySingleton
class FeedbackEmailRemoteDataSource {
  const FeedbackEmailRemoteDataSource();

  Future<void> sendFeedbackEmail({
    required String subject,
    required String body,
  }) {
    final Resend resend = Resend.instance;
    return resend.sendEmail(
      from: constants.feedbackEmailSender,
      to: <String>[constants.supportEmail],
      subject: subject,
      text: body,
    );
  }
}
