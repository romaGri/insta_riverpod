import 'dart:async';

import 'package:flutter/material.dart';

extension GetImageAspectRatio on Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (image, synchronousCall) {
          final aspectRatio = image.image.width / image.image.height;
          image.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );

    return completer.future;
  }
}
