import 'package:injectable/injectable.dart';

import '../../user/models/user.dart';
import 'firebase_auth_services.dart';
import 'firebase_firestore_services.dart';
import 'firebase_messaging_services.dart';
import 'google_services.dart';
import 'i_auth_services.dart';

@Injectable(as: IAuthServices)
class AuthServices implements IAuthServices {
  final GoogleServices _googleServices;
  final FirebaseAuthServices _auth;
  final FirebaseFirestoreServices _firestoreServices;
  final FirebaseMessaginServices _messaginServices;

  AuthServices(
    this._googleServices,
    this._auth,
    this._firestoreServices,
    this._messaginServices,
  );

  @override
  Future<User?> googleSignIn() async {
    final credentials = await _googleServices.signIn();

    if (credentials == null) {
      await logOut();
      return null;
    }

    final userId = await _auth.signIn(
      accessToken: credentials.accessToken,
      idToken: credentials.idToken,
    );

    if (userId == null) {
      await logOut();
      return null;
    }

    final user = User(
      id: userId,
      displayName: credentials.displayName,
      email: credentials.email,
      photoUrl: credentials.photoUrl,
    );

    return user;
  }

  @override
  Future<User?> saveUser(User user) async {
    final savedUser = await _firestoreServices.saveUser(user);

    _messaginServices.getUserToken().then((token) {
      if (token != null) {
        _firestoreServices.saveToken(
          userId: user.id,
          token: token,
        );
      }
    });

    return savedUser;
  }

  @override
  Future<bool> logOut() async {
    try {
      await _googleServices.logOut();
      await _auth.logOut();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  User? getCurrentUser() {
    final currentUser = _auth.currentUser();

    if (currentUser != null) {
      _messaginServices.getUserToken().then((token) {
        if (token != null) {
          _firestoreServices.saveToken(
            userId: currentUser.id,
            token: token,
          );
        }
      });
    }

    return currentUser;
  }
}
