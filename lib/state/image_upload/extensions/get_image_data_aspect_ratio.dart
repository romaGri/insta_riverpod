import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_riverpod/state/image_upload/extensions/get_image_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getImageDataAspectRatio() {
    final image = Image.memory(this);
    return image.getAspectRatio();
  }
}
