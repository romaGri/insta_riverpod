import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_riverpod/state/auth/constants/const.dart';
import 'package:insta_riverpod/state/auth/models/index.dart';

class Authenticator {
  const Authenticator();

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  bool get isAlreadyLoggedIn => userId != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    //await FacebookAuth.instance.logOut();
  }

  // Future<AuthResult> logInWithFacebook() async {
  //   final loginResult = await FacebookAuth.instance.login();
  //   final token = loginResult.accessToken?.token;
  //   if (token == null) {
  //     return AuthResult.aborted;
  //   }

  //   final oauthCredential = FacebookAuthProvider.credential(token);
  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(oauthCredential);

  //     return AuthResult.success;
  //   } on FirebaseAuthException catch (e) {
  //     final email = e.email;
  //     final credential = e.credential;

  //     if (e.code == Constants.accountExistsWithDifferentCredential &&
  //         email != null &&
  //         credential != null) {
  //       final providers =
  //           await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

  //       if (providers.contains(Constants.googleCom)) {
  //         await logInWithGoogle();
  //         FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  //       }

  //       return AuthResult.success;
  //     }

  //     return AuthResult.failure;
  //   }
  // }

  Future<AuthResult> logInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: [Constants.emailScope],
    );

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
