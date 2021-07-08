import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/user/models/user.dart';
import 'i_login_services.dart';

@Injectable(as: ILoginServices)
class LoginServices implements ILoginServices {
  final GoogleSignIn _googleSignIn;

  LoginServices(this._googleSignIn);

  @override
  Future<User?> googleSignIn() async {
    try {
      final response = await _googleSignIn.signIn();

      if (response != null) {
        return User(
          displayName: response.displayName ?? "Usuário",
          email: response.email,
          id: response.id,
          photoUrl: response.photoUrl,
        );
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
