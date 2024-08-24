import 'package:formz/formz.dart';
import 'package:models/res/constants.dart' as constants;
import 'package:models/src/validation_error.dart';

class EmailAddress extends FormzInput<String, EmailValidationError> {
  const EmailAddress.pure() : super.pure('');

  const EmailAddress.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.length < constants.emailMinLength ||
        value.length > constants.emailMaxLength ||
        !RegExp(_kEmailPattern).hasMatch(value.trim())) {
      return const EmptyEmailValidationError();
    }
    return null;
  }
}

const String _kEmailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]'
    r'{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]'
    r'{2,}))$';
