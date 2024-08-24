abstract class ValidationError {
  const ValidationError();
}

sealed class EmailValidationError extends ValidationError {
  const EmailValidationError();
}

final class EmptyEmailValidationError extends EmailValidationError {
  const EmptyEmailValidationError();
}

sealed class PasswordValidationError extends ValidationError {
  const PasswordValidationError();
}

final class EmptyPasswordValidationError extends PasswordValidationError {
  const EmptyPasswordValidationError();
}
