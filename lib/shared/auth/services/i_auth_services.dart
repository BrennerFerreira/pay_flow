import 'package:boleto_organizer/shared/user/models/user.dart';

abstract class IAuthServices {
  Future<User?> googleSignIn();

  Future<User?> saveUser(User user);

  Future<bool> logOut();

  Future<User?> getCurrentUser();
}
