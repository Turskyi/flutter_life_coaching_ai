import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/ui/sign_up/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    this.email = '',
    this.password = '',
    super.key,
  });

  final String email;
  final String password;

  static Route<void> route({required String email, String password = ''}) =>
      MaterialPageRoute<void>(
        builder: (_) => SignUpPage(
          email: email,
          password: password,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: SignUpForm(email: email, password: password),
        ),
      ),
    );
  }
}
