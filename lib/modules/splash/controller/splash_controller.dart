import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/routes_names.dart';
import '../../../shared/auth/controller/auth_controller.dart';

class SplashController {
  void checkLoggedUser(BuildContext context) {
    context.read<AuthController>().getCurrentUser().then((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
      } else {
        Navigator.pushReplacementNamed(context, HOME_ROUTE);
      }
    });
  }
}
