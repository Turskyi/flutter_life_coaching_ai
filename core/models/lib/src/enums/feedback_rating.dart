import 'package:flutter_translate/flutter_translate.dart';

/// A user-provided sentiment rating.
enum FeedbackRating {
  bad,
  neutral,
  good;

  String get value {
    switch (this) {
      case FeedbackRating.bad:
        return translate('feedback.bad');
      case FeedbackRating.neutral:
        return translate('feedback.neutral');
      case FeedbackRating.good:
        return translate('feedback.good');
    }
  }
}
