import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../shared/auth/auth_controller.dart';
import '../../../shared/user/models/user.dart';

class LoginController {
  Future<void> googleSignIn(BuildContext context) async {
    final GoogleSignIn _signIn = GoogleSignIn(scopes: ['email']);
    final AuthController _authController = AuthController();
    try {
      final response = await _signIn.signIn();
      User? user;

      if (response != null) {
        user = User(
          displayName: response.displayName ?? "Usuário",
          email: response.email,
          id: response.id,
          photoUrl: response.photoUrl,
        );
      }

      _authController.setUser(context, user);
    } catch (error) {
      print(error);
    }
  }
}
