import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:insta_riverpod/state/image_upload/extensions/to_file.dart';

class ImagePickerHelper {
  static final ImagePicker _imagePiker = ImagePicker();

  static Future<File?> pickImageFromGallery() =>
      _imagePiker.pickImage(source: ImageSource.gallery).toFile();

  static Future<File?> pickVideoFromGallery() =>
      _imagePiker.pickVideo(source: ImageSource.gallery).toFile();
}
