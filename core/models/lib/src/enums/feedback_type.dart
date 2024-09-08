import 'package:flutter_translate/flutter_translate.dart';

/// What type of feedback the user wants to provide.
enum FeedbackType {
  bugReport,
  featureRequest;

  String get value {
    switch (this) {
      case FeedbackType.bugReport:
        return translate('feedback.bugReport');
      case FeedbackType.featureRequest:
        return translate('feedback.featureRequest');
    }
  }
}
