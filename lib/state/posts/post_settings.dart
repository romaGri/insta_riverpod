import 'package:insta_riverpod/views/components/constants/strings.dart';

enum PostSettings {
  allowLikes(
    title: Strings.allowLikesTitle,
    description: Strings.allowLikesDescription,
    storageKey: Strings.allowLikesStorageKey,
  ),
  allowComments(
    title: Strings.allowCommentsTitle,
    description: Strings.allowCommentsDescription,
    storageKey: Strings.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
