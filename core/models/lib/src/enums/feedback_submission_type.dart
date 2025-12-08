enum FeedbackSubmissionType {
  manual,
  automatic;

  bool get isAutomatic => this == automatic;
}
