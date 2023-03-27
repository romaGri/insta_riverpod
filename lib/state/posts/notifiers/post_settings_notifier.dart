import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/posts/models/index.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostSettingsNotifier()
      : super(
          UnmodifiableMapView(
            {for (final settings in PostSettings.values) settings: true},
          ),
        );

  void setSetting(
    PostSettings settings,
    bool value,
  ) {
    final existingValue = state[settings];

    if (existingValue == null || existingValue == value) {
      return;
    }

    state = Map.unmodifiable(
      Map.from(state)..[settings] = value,
    );
  }
}
