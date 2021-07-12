import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseAuthServices {
  final FirebaseAuth _auth;

  FirebaseAuthServices(this._auth);

  Future<String?> signIn({
    required String? accessToken,
    required String? idToken,
  }) async {
    try {
      final credential = GoogleAuthProvider.credential(
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

  String? currentUser() {
    final currentUser = _auth.currentUser;

    return currentUser?.uid;
  }
}
