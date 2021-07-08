import '../../../shared/user/models/user.dart';

abstract class ILoginServices {
  Future<User?> googleSignIn();
}
