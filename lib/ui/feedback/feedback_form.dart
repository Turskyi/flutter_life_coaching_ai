import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:laozi_ai/entities/enums/feedback_rating.dart';
import 'package:laozi_ai/entities/enums/feedback_type.dart';
import 'package:laozi_ai/entities/feedback_details.dart';

/// A form that prompts the user for the type of feedback they want to give,
/// free form text feedback, and a sentiment rating.
/// The submit button is disabled until the user provides the feedback type. All
/// other fields are optional.
class FeedbackForm extends StatefulWidget {
  const FeedbackForm({
    required this.onSubmit,
    required this.scrollController,
    super.key,
  });

  final OnSubmit onSubmit;
  final ScrollController? scrollController;

  @override
  State<FeedbackForm> createState() => _CustomFeedbackFormState();
}

class _CustomFeedbackFormState extends State<FeedbackForm> {
  final FeedbackDetails _customFeedback = FeedbackDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              if (widget.scrollController != null)
                const FeedbackSheetDragHandle(),
              ListView(
                controller: widget.scrollController,
                // Pad the top by 20 to match the corner radius if drag enabled.
                padding: EdgeInsets.fromLTRB(
                  16,
                  widget.scrollController != null ? 20 : 16,
                  16,
                  0,
                ),
                children: <Widget>[
                  Text(translate('feedback.whatKind')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text('*'),
                      ),
                      Flexible(
                        child: DropdownButton<FeedbackType>(
                          value: _customFeedback.feedbackType,
                          items: FeedbackType.values
                              .map(
                                (FeedbackType type) =>
                                    DropdownMenuItem<FeedbackType>(
                                  value: type,
                                  child: Text(type.value),
                                ),
                              )
                              .toList(),
                          onChanged: (FeedbackType? feedbackType) => setState(
                            () => _customFeedback.feedbackType = feedbackType,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(translate('feedback.whatIsYourFeedback')),
                  TextField(
                    onChanged: (String newFeedback) =>
                        _customFeedback.feedbackText = newFeedback,
                  ),
                  const SizedBox(height: 16),
                  Text(translate('feedback.howDoesThisFeel')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: FeedbackRating.values.map(_ratingToIcon).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
        TextButton(
          // disable this button until the user has specified a feedback type
          onPressed: _customFeedback.feedbackType != null
              ? () => widget.onSubmit(
                    _customFeedback.feedbackText ?? '',
                    extras: _customFeedback.toMap(),
                  )
              : null,
          child: Text(translate('submit')),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _ratingToIcon(FeedbackRating rating) {
    final bool isSelected = _customFeedback.rating == rating;
    late IconData icon;
    switch (rating) {
      case FeedbackRating.bad:
        icon = Icons.sentiment_dissatisfied;
        break;
      case FeedbackRating.neutral:
        icon = Icons.sentiment_neutral;
        break;
      case FeedbackRating.good:
        icon = Icons.sentiment_satisfied;
        break;
    }
    return IconButton(
      color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey,
      onPressed: () => setState(() => _customFeedback.rating = rating),
      icon: Icon(icon),
      iconSize: 36,
    );
  }
}
