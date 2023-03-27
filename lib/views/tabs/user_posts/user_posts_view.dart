import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/providers/user_post_provider.dart';
import 'package:insta_riverpod/views/components/animations/content/empty_content_animation_view.dart';
import 'package:insta_riverpod/views/components/animations/index.dart';
import 'package:insta_riverpod/views/components/animations/loading_animation_view.dart';
import 'package:insta_riverpod/views/components/constants/strings.dart';
import 'package:insta_riverpod/views/components/post/posts_grid_view.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(userPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(data: (posts) {
        return posts.isEmpty
            ? const EmptyContentAnimationView(
                text: Strings.youHaveNoPosts,
              )
            : PostGridView(
                posts: posts,
              );
      }, error: (error, stackTrace) {
        return const ErrorAnimationView();
      }, loading: () {
        return const LoadingAnimationView();
      }),
    );
  }
}
