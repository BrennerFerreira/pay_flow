import 'package:boleto_organizer/shared/auth/services/i_auth_services.dart';
import 'package:boleto_organizer/shared/user/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: IAuthServices)
class AuthServices implements IAuthServices {
  final SharedPreferences _instance;

  AuthServices(this._instance);

  @override
  Future<User?> saveUser(User user) async {
    final result = await _instance.setString("user", user.toJson());
    if (result) {
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<bool> logOut() async {
    final result = await _instance.remove("user");
    return result;
  }

  @override
  Future<User?> getCurrentUser() async {
    final userJson = _instance.getString("user");

    if (userJson == null) {
      return null;
    }

    return User.fromJson(userJson);
  }
}
