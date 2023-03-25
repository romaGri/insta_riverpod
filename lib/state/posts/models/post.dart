import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_riverpod/state/image_upload/models/file_type.dart';
import 'package:insta_riverpod/state/posts/models/index.dart';

class Post {
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final String fileName;
  final FileType fileType;
  final double aspectRatio;
  final Map<PostSettings, bool> postSettings;
  final String thumbnailStorageId;
  final String originalFileStorageId;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        fileName = json[PostKey.fileName],
        aspectRatio = json[PostKey.aspectRatio],
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalFileStorageId = json[PostKey.originalFileStorageId],
        fileType = FileType.values.firstWhere(
          (element) => element.name == json[PostKey.fileType],
          orElse: () => FileType.image,
        ),
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSettings.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value,
        };

  bool get isLikesAllowed => postSettings[PostSettings.allowLikes] ?? false;

  bool get isCommentsAllowed =>
      postSettings[PostSettings.allowComments] ?? false;
}
