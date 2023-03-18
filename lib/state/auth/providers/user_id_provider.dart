import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_riverpod/state/auth/providers/auth_state_provider.dart';

final userIdProvider =
    Provider<String?>((ref) => ref.watch(authStateProvider).userId);
