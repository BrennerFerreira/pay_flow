import 'package:injectable/injectable.dart';

import '../../../injectable.dart';
import '../../../shared/auth/controller/auth_controller.dart';
import '../../../shared/user/models/user.dart';
import '../services/i_login_services.dart';

@Injectable()
class LoginController {
  final ILoginServices _services;

  LoginController(this._services);

  Future<void> googleSignIn() async {
    final AuthController _authController = getIt<AuthController>();
    final User? user = await _services.googleSignIn();

    if (user != null) {
      await _authController.saveUser(user);
    }
  }
}
