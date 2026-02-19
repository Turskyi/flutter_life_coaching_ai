abstract interface class AiConsentRepository {
  const AiConsentRepository();

  /// Check if the user has already given AI consent.
  Future<bool> hasAiConsent();

  /// Store the user's AI consent decision.
  Future<void> setAiConsent(bool consent);
}
