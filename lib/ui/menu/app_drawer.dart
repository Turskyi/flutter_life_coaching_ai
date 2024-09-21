import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifecoach/application_services/blocs/authentication/authentication.dart';
import 'package:lifecoach/ui/privacy/privacy_policy_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/logo-no-bg.png'),
                fit: BoxFit.contain,
              ),
              gradient: LinearGradient(
                colors: <Color>[
                  theme.colorScheme.onPrimary,
                  theme.colorScheme.onSecondaryFixed,
                  theme.scaffoldBackgroundColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const PrivacyPolicyPage(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () => context
                .read<AuthenticationBloc>()
                .add(const AuthenticationSignOutPressed()),
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              const double progressIndicatorSize = 24.0;
              final AuthenticationStatus status = state.status;
              final bool isDeleting = status is DeletingAuthenticatedUserStatus;
              return ListTile(
                leading: const Icon(Icons.delete_forever),
                title: const Text('Delete Account'),
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
                            await _showDeleteAccountConfirmationDialog(
                          context,
                        );
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

  Future<bool?> _showDeleteAccountConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account?\n'
            'This action cannot be undone.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
