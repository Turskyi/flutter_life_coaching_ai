import 'package:formz/formz.dart';
import 'package:models/src/validation_error.dart';

class Code extends FormzInput<String, CodeValidationError> {
  const Code.pure() : super.pure('');

  const Code.dirty([super.value = '']) : super.dirty();

  @override
  CodeValidationError? validator(String value) {
    if (value.isEmpty) return const EmptyCodeValidationError();
    return null;
  }
}
