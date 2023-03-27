import 'dart:collection';

import 'package:insta_riverpod/state/const/firebase_filed_names.dart';

class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required String userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}
