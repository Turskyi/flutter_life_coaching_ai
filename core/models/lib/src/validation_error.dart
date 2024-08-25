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

sealed class CodeValidationError extends ValidationError {
  const CodeValidationError();
}

final class EmptyPasswordValidationError extends PasswordValidationError {
  const EmptyPasswordValidationError();
}

final class EmptyCodeValidationError extends CodeValidationError {
  const EmptyCodeValidationError();
}
