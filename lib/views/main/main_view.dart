import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/auth/providers/auth_state_provider.dart';
import 'package:insta_riverpod/views/components/constants/strings.dart';
import 'package:insta_riverpod/views/components/dialogs/alert_dialog_model.dart';
import 'package:insta_riverpod/views/components/dialogs/logout_dialog.dart';
import 'package:insta_riverpod/views/tabs/user_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.photoFilm,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () async {
                final shouldLogout = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogout) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
            )
          ],
          bottom: const TabBar(
            enableFeedback: true,
            tabs: [
              Icon(Icons.person_2),
              Icon(Icons.search),
              Icon(Icons.home_filled),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
