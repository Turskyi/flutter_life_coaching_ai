import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:lifecoach/application_services/blocs/authentication/authentication.dart';
import 'package:lifecoach/application_services/blocs/goals/goals_bloc.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';
import 'package:lifecoach/ui/privacy/privacy_policy_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('${constants.imagePath}logo-no-bg.png'),
                fit: BoxFit.contain,
              ),
              gradient: LinearGradient(
                colors: <Color>[
                  colorScheme.onPrimary,
                  colorScheme.onSecondaryFixed,
                  theme.scaffoldBackgroundColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const SizedBox.shrink(),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(translate('menu.language')),
            trailing: Text(
              _getLanguageName(LocalizedApp.of(context).delegate.currentLocale),
            ),
            onTap: () => _showLanguageSelector(context),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(translate('menu.support')),
            onTap: () => Navigator.of(context).pushNamed(AppRoute.support.path),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(translate('menu.about')),
            onTap: () => _openAbout(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(translate('menu.privacyPolicy')),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const PrivacyPolicyPage(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(translate('menu.signOut')),
            onTap: () => context.read<AuthenticationBloc>().add(
              const AuthenticationSignOutPressed(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: Text(translate('report_bug')),
            onTap: () => _onBugReportPressed(context),
          ),
          const Divider(),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              const double progressIndicatorSize = 24.0;
              final AuthenticationStatus status = state.status;
              final bool isDeleting = status is DeletingAuthenticatedUserStatus;
              return ListTile(
                leading: Icon(Icons.delete_forever, color: colorScheme.error),
                title: Text(
                  translate('menu.deleteAccount'),
                  style: TextStyle(color: colorScheme.error),
                ),
                trailing: isDeleting
                    ? const SizedBox(
                        width: progressIndicatorSize,
                        height: progressIndicatorSize,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
                onTap: isDeleting
                    ? null
                    : () async {
                        final bool? confirmed =
                            await _showDeleteAccountConfirmationDialog(context);
                        if (context.mounted && confirmed == true) {
                          context.read<AuthenticationBloc>().add(
                            const AuthenticationAccountDeletionRequested(),
                          );
                        }
                      },
              );
            },
          ),
        ],
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return translate('languages.en');
      case 'uk':
        return translate('languages.uk');
      default:
        return locale.languageCode;
    }
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: Text(translate('languages.en')),
                onTap: () {
                  changeLocale(context, 'en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇦', style: TextStyle(fontSize: 24)),
                title: Text(translate('languages.uk')),
                onTap: () {
                  changeLocale(context, 'uk');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> _showDeleteAccountConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('menu.deleteAccount')),
          content: Text(translate('menu.deleteAccountConfirmation')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(translate('menu.cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(translate('menu.delete')),
            ),
          ],
        );
      },
    );
  }

  void _onBugReportPressed(BuildContext context) {
    final GoalsState state = context.read<GoalsBloc>().state;
    context.read<GoalsBloc>().add(
      BugReportPressedEvent(state is GoalsError ? state.errorText : ''),
    );
  }

  void _openAbout(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoute.about.path);
  }
}
