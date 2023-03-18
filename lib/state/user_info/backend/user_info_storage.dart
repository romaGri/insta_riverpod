import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_riverpod/state/const/firebase_collection_name.dart';
import 'package:insta_riverpod/state/const/firebase_filed_names.dart';
import 'package:insta_riverpod/state/user_info/models/user_info_payload.dart';

class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required String userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FireBaseCollectionName.users)
          .where(FireBaseFieldNames.userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FireBaseFieldNames.displayName: displayName,
          FireBaseFieldNames.email: email ?? '',
        });
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await FirebaseFirestore.instance
          .collection(FireBaseCollectionName.users)
          .add(payload);

      return true;
    } catch (e) {
      return false;
    }
  }
}
