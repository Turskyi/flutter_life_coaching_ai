import 'package:models/src/enums/feedback_rating.dart';
import 'package:models/src/enums/feedback_type.dart';

/// A data type holding user feedback consisting of a feedback type, free from
/// feedback text, and a sentiment rating.
class FeedbackDetails {
  const FeedbackDetails({
    this.feedbackType,
    this.feedbackText,
    this.rating,
  });

  final FeedbackType? feedbackType;
  final String? feedbackText;
  final FeedbackRating? rating;

  FeedbackDetails copyWith({
    FeedbackType? feedbackType,
    String? feedbackText,
    FeedbackRating? rating,
  }) =>
      FeedbackDetails(
        feedbackType: feedbackType ?? this.feedbackType,
        feedbackText: feedbackText ?? this.feedbackText,
        rating: rating ?? this.rating,
      );

  @override
  String toString() {
    return <String, String?>{
      if (rating != null) 'rating': rating.toString(),
      'feedback_type': feedbackType.toString(),
      'feedback_text': feedbackText,
    }.toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (rating != null) 'rating': rating,
      'feedback_type': feedbackType,
      'feedback_text': feedbackText,
    };
  }
}
