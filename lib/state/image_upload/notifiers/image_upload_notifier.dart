import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/const/index.dart';
import 'package:insta_riverpod/state/image_upload/constants/image_upload_const.dart';
import 'package:insta_riverpod/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:insta_riverpod/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:insta_riverpod/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:insta_riverpod/state/image_upload/models/file_type.dart';
import 'package:insta_riverpod/state/posts/models/post_payload.dart';
import 'package:insta_riverpod/state/posts/post_settings.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<bool> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSettings, bool> postSettings,
    required String userId,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(
          file.readAsBytesSync(),
        );

        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: ImageUploadConst.imageThumbnailWidth,
        );

        final thumbnailData = img.encodeJpg(thumbnail);

        thumbnailUint8List = Uint8List.fromList(thumbnailData);

        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: ImageUploadConst.videoThumbnailMaxHeight,
          quality: ImageUploadConst.videoThumbnailQuality,
        );

        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }

    final thumbnailAspectRatio =
        await thumbnailUint8List.getImageDataAspectRatio();

    final fileName = const Uuid().v4();

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FireBaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      final originalFileUploadTask = await thumbnailRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
        postSettings: postSettings,
      );

      await FirebaseFirestore.instance
          .collection(FireBaseCollectionName.posts)
          .add(postPayload);

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}