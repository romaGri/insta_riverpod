import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/auth/providers/user_id_provider.dart';
import 'package:insta_riverpod/state/image_upload/models/file_type.dart';
import 'package:insta_riverpod/state/image_upload/models/thumbnail_request.dart';
import 'package:insta_riverpod/state/image_upload/providers/image_uploader_provider.dart';
import 'package:insta_riverpod/state/posts/models/index.dart';
import 'package:insta_riverpod/state/posts/providers/post_settings_provider.dart';
import 'package:insta_riverpod/views/components/constants/strings.dart';
import 'package:insta_riverpod/views/components/thumbnail/thumbnail_view.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreateNewPostView({
    required this.fileToPost,
    required this.fileType,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );

    final postSettings = ref.watch(postSettingsProvider);

    final textController = useTextEditingController();

    final isPostButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          isPostButtonEnabled.value = textController.text.isNotEmpty;
        }

        textController.addListener(listener);
        return () {
          textController.removeListener(listener);
        };
      },
      [textController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.createNewPost,
        ),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }

                    final message = textController.text;
                    final isUploaded =
                        await ref.read(imageUploaderProvider.notifier).upload(
                              file: widget.fileToPost,
                              fileType: widget.fileType,
                              message: message,
                              postSettings: postSettings,
                              userId: userId,
                            );

                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FileThumbnailView(
              thumbnailRequest: thumbnailRequest,
            ),
            TextField(
              autofocus: true,
              maxLines: null,
              decoration: const InputDecoration(
                  labelText: Strings.pleaseWriteYourMessageHere),
              controller: textController,
            ),
            ...PostSetting.values.map(
              (postSetting) => ListTile(
                title: Text(postSetting.title),
                subtitle: Text(postSetting.description),
                trailing: Switch(
                  value: postSettings[postSettings] ?? false,
                  onChanged: (isOn) {
                    ref.read(postSettingsProvider.notifier).setSetting(
                          postSetting,
                          isOn,
                        );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
