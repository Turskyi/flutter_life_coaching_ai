import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/sign_up/bloc/sign_up_bloc.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({super.key});

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  final List<TextEditingController> _controllers =
      List<TextEditingController>.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).nextFocus();
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
    final String code = _controllers
        .map((TextEditingController controller) => controller.text)
        .join();
    context.read<SignUpBloc>().add(CodeChanged(code));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<SizedBox>.generate(6, (int index) {
        return SizedBox(
          width: 40,
          child: TextField(
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (String value) => _onChanged(value, index),
            decoration: InputDecoration(
              counterText: '',
              errorText: context.select(
                        (SignUpBloc bloc) => bloc.state.code.displayError,
                      ) !=
                      null
                  ? 'Invalid code'
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
