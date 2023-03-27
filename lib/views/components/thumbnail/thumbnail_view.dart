import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/image_upload/models/thumbnail_request.dart';
import 'package:insta_riverpod/state/image_upload/providers/thumbnail_provider.dart';
import 'package:insta_riverpod/views/components/animations/index.dart';
import 'package:insta_riverpod/views/components/animations/loading_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const FileThumbnailView({
    required this.thumbnailRequest,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(
      data: (image) {
        return AspectRatio(
          aspectRatio: image.aspectRatio,
          child: image.image,
        );
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const LoadingAnimationView();
      },
    );
  }
}
