import 'package:boleto_organizer/shared/user/models/user.dart';

abstract class IAuthServices {
  Future<User?> saveUser(User user);

  Future<bool> logOut();

  Future<User?> getCurrentUser();
}
