import 'package:flutter/foundation.dart';
import 'package:insta_riverpod/state/auth/models/auth_result.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final String? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  String func(AuthState a) {
    return 'a';
  }

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(result, isLoading, userId);
}
