import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/auth/providers/user_id_provider.dart';
import 'package:insta_riverpod/state/const/index.dart';
import 'package:insta_riverpod/state/posts/models/index.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final userId = ref.watch(userIdProvider);

  final controller = StreamController<Iterable<Post>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FireBaseCollectionName.posts)
      .orderBy(
        FireBaseFieldNames.createdAt,
        descending: true,
      )
      .where(PostKey.userId, isEqualTo: userId)
      .snapshots()
      .listen((event) {
    final documents = event.docs;
    final posts = documents
        .where(
          (element) => !element.metadata.hasPendingWrites,
        )
        .map(
          (element) => Post(
            postId: element.id,
            json: element.data(),
          ),
        );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
