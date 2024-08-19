import 'package:formz/formz.dart';
import 'package:lifecoach/models/enums/username_validation_error.dart';

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');

  const Username.dirty([super.value = '']) : super.dirty();

  //FIXME: For simplicity, we are just validating the username to ensure that
  // it is not empty but in practice we can enforce special character usage,
  // length, etc…
  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
