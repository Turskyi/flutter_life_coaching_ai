import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/sign_up/bloc/sign_up_bloc.dart';
import 'package:lifecoach/ui/sign_up/code_form.dart';

class CodePage extends StatelessWidget {
  const CodePage({super.key});

  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const CodePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: const CodeForm(),
        ),
      ),
    );
  }
}
