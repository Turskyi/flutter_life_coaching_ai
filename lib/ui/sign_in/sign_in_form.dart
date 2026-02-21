import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:formz/formz.dart';
import 'package:lifecoach/application_services/blocs/sign_in/bloc/sign_in_bloc.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/sign_in/continue_button.dart';
import 'package:lifecoach/ui/sign_in/email_input.dart';
import 'package:lifecoach/ui/sign_in/password_input.dart';
import 'package:lifecoach/ui/sign_in/sign_up_prompt.dart';
import 'package:url_launcher/url_launcher.dart';

/// The [SignInForm] handles notifying the [SignInBloc] of user events and
/// also responds to state changes using [BlocBuilder] and [BlocListener].
/// [BlocListener] is used to show a [SnackBar] if the login submission fails.
/// In addition, [BlocBuilder] widgets are used to wrap each of the [TextField]
/// widgets and make use of the `buildWhen` property in order to optimize for
/// rebuilds. The `onChanged` callback is used to notify the [SignInBloc] of
/// changes to the email/password.
class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // Tracks whether the user has checked the box.
  bool _isConsentGiven = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: _signInStateListener,
      builder: (_, SignInState state) {
        return Align(
          alignment: const Alignment(0, -1 / 3),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const EmailInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  const PasswordInput(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: state.email.isValid
                          ? () => context.read<SignInBloc>().add(
                              const ForgotPasswordRequested(),
                            )
                          : null,
                      child: Text(translate('sign_in.forgot_password')),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(12)),
                  CheckboxListTile(
                    title: RichText(
                      text: TextSpan(
                        text: translate('sign_in.consent_message'),
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <InlineSpan>[
                          TextSpan(
                            text: translate('sign_in.learn_more'),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchPrivacyPolicy(context);
                              },
                          ),
                        ],
                      ),
                    ),
                    value: _isConsentGiven,
                    onChanged: (bool? value) {
                      setState(() {
                        _isConsentGiven = value ?? false;
                      });
                    },
                  ),
                  ContinueButton(
                    onPressed: _isConsentGiven
                        ? () => context.read<SignInBloc>().add(
                            const SignInSubmitted(),
                          )
                        : null, // Disable button if consent is not given
                  ),
                  const Padding(padding: EdgeInsets.all(12)),
                  SignUpPrompt(
                    email: state.email.value,
                    password: state.password.value,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _signInStateListener(BuildContext context, SignInState state) {
    if (state.status.isFailure || state is SignInErrorState) {
      Widget contentWidget;
      const String officialWebsiteUrl = constants.website;
      if (kIsWeb) {
        contentWidget = SelectableText.rich(
          TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: translate('sign_in.use_website'),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: officialWebsiteUrl,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final Uri url = Uri.parse(officialWebsiteUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, webOnlyWindowName: '_blank');
                    } else {
                      debugPrint('Could not launch $officialWebsiteUrl');
                    }
                  },
              ),
            ],
          ),
        );
      } else {
        String errorMessage;
        if (state is SignInErrorState) {
          errorMessage = state.errorMessage;
        } else {
          errorMessage = translate('sign_in.auth_failure');
        }

        final bool isPasswordError =
            (state is SignInErrorState) &&
            state.errorMessage.toLowerCase().contains('password');

        contentWidget = Row(
          children: <Widget>[
            Expanded(child: SelectableText(errorMessage)),
            if (isPasswordError)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  context.read<SignInBloc>().add(
                    const ForgotPasswordRequested(),
                  );
                },
                child: Text(translate('sign_in.reset_action')),
              ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text(translate('sign_in.ok_action')),
            ),
          ],
        );
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: contentWidget,
            duration: const Duration(seconds: 10),
          ),
        );
    }
  }

  void _launchPrivacyPolicy(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.privacyPolity.path);
  }
}
