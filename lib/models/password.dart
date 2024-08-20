import 'package:formz/formz.dart';
import 'package:lifecoach/models/validation_error.dart';

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return const EmptyPasswordValidationError();
    return null;
  }
}
