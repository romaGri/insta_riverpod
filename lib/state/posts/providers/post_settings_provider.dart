import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/posts/models/index.dart';
import 'package:insta_riverpod/state/posts/notifiers/post_settings_notifier.dart';

final postSettingsProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSettings, bool>>(
  (ref) => PostSettingsNotifier(),
);
