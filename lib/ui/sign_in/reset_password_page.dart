import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/application_services/blocs/sign_in/bloc/sign_in_bloc.dart';
import 'package:lifecoach/ui/sign_in/reset_password_form.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({required this.email, super.key});

  final String email;

  static Route<void> route({required String email}) {
    return MaterialPageRoute<void>(
      builder: (BuildContext _) => ResetPasswordPage(email: email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(translate('reset_password.title'))),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<SignInBloc>(
          create: (BuildContext context) => SignInBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: ResetPasswordForm(email: email),
        ),
      ),
    );
  }
}
