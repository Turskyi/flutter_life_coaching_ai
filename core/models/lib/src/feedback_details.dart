import 'package:laozi_ai/entities/enums/feedback_rating.dart';
import 'package:laozi_ai/entities/enums/feedback_type.dart';

/// A data type holding user feedback consisting of a feedback type, free from
/// feedback text, and a sentiment rating.
class FeedbackDetails {
  FeedbackDetails({
    this.feedbackType,
    this.feedbackText,
    this.rating,
  });

  FeedbackType? feedbackType;
  String? feedbackText;
  FeedbackRating? rating;

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
