import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/auth/providers/auth_state_provider.dart';
import 'package:insta_riverpod/state/auth/providers/is_logged_in_provider.dart';
import 'package:insta_riverpod/state/providers/is_loading_provider.dart';
import 'package:insta_riverpod/views/components/loading/loading_screen.dart';
import 'firebase_options.dart';

// import 'dart:developer' as devtools show log;

// extension Log on Object {
//   void log() => devtools.log(toString());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Riverpod',
      theme: ThemeData.dark(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            isLoadingProvider,
            (previous, next) {
              if (next) {
                LoadingScreen.instance().show(context: context);
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );

          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Center(
        child: Consumer(
          builder: (_, ref, child) => TextButton(
            onPressed: () async {
              ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text('Google logOut'),
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Consumer(
              builder: (context, ref, child) => TextButton(
                onPressed: () async {
                  ref.read(authStateProvider.notifier).loginWithGoogle();
                },
                child: const Text('Google'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
