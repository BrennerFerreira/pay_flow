import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

class _SignInResponse {
  final String? accessToken;
  final String? idToken;
  final String displayName;
  final String? photoUrl;
  final String email;

  _SignInResponse({
    required this.accessToken,
    required this.idToken,
    required this.displayName,
    required this.photoUrl,
    required this.email,
  });
}

@injectable
class GoogleServices {
  final GoogleSignIn _googleSignIn;

  GoogleServices(this._googleSignIn);

  Future<_SignInResponse?> signIn() async {
    final response = await _googleSignIn.signIn();

    if (response == null) {
      return null;
    }

    final googleAuth = await response.authentication;

    final credientialsMap = _SignInResponse(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
      displayName: response.displayName ?? "Usuário",
      photoUrl: response.photoUrl,
      email: response.email,
    );

    return credientialsMap;
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
  }
}
