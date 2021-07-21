import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:injectable/injectable.dart';

import '../../user/models/user.dart';

@injectable
class FirebaseAuthServices {
  final auth.FirebaseAuth _auth;

  FirebaseAuthServices(this._auth);

  Future<String?> signIn({
    required String? accessToken,
    required String? idToken,
  }) async {
    try {
      final credential = auth.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final signedInUser = await _auth.signInWithCredential(credential);

      return signedInUser.user!.uid;
    } catch (_) {
      return null;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  User? currentUser() {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return null;
    }

    final User user = User(
      displayName: currentUser.displayName ?? "Usuário",
      email: currentUser.email ?? "",
      id: currentUser.uid,
      photoUrl: currentUser.photoURL,
    );

    return user;
  }

  Future<bool?> deleteAccount({
    required String? accessToken,
    required String? idToken,
  }) async {
    try {
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        return null;
      }

      final credential = auth.GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      await _auth.currentUser!.reauthenticateWithCredential(credential);

      await _auth.currentUser!.delete();

      return true;
    } on auth.FirebaseException {
      return false;
    }
  }
}
