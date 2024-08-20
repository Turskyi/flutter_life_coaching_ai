import 'package:formz/formz.dart';
import 'package:lifecoach/models/validation_error.dart';
import 'package:lifecoach/res/constants.dart' as constants;

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([super.value = '']) : super.dirty();

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
