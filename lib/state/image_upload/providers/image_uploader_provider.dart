import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/image_upload/notifiers/image_upload_notifier.dart';

final imageUploaderProvider = StateNotifierProvider<ImageUploadNotifier, bool>(
  (ref) => ImageUploadNotifier(),
);
