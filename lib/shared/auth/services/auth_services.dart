import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user/models/user.dart';
import 'i_auth_services.dart';

@Injectable(as: IAuthServices)
class AuthServices implements IAuthServices {
  final SharedPreferences _instance;
  final GoogleSignIn _googleSignIn;

  AuthServices(this._instance, this._googleSignIn);

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

  @override
  Future<User?> saveUser(User user) async {
    final saveSuccess = await _instance.setString("user", user.toJson());

    return saveSuccess ? user : null;
  }

  @override
  Future<bool> logOut() async {
    await _googleSignIn.disconnect();
    final result = await _instance.remove("user");
    return result;
  }

  @override
  Future<User?> getCurrentUser() async {
    final userJson = _instance.getString("user");

    return userJson != null ? User.fromJson(userJson) : null;
  }
}
