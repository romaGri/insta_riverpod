import 'package:flutter/material.dart';
import 'package:insta_riverpod/state/posts/models/post.dart';
import 'package:insta_riverpod/views/components/post/post_thumbnail_view.dart';

class PostGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostGridView({
    required this.posts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTap: () {},
        );
      },
    );
  }
}
