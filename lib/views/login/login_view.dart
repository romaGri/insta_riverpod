import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/auth/providers/auth_state_provider.dart';
import 'package:insta_riverpod/views/components/constants/strings.dart';
import 'package:insta_riverpod/views/constants/app_colors.dart';
import 'package:insta_riverpod/views/login/google_login_button.dart';
import 'package:insta_riverpod/views/login/login_view_sign_up_links.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const _LoginViewDivider(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                child: const GoogleLoginButton(),
              ),
              const _LoginViewDivider(),
              const LoginSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginViewDivider extends StatelessWidget {
  const _LoginViewDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 40.0,
      ),
      child: Divider(),
    );
  }
}
