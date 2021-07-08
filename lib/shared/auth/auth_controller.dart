import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/routes/routes_names.dart';
import '../user/models/user.dart';

class AuthController {
  User? _user;

  User? get user => _user;

  void setUser(BuildContext context, User? user) {
    if (user != null) {
      _user = user;
      saveUser(user);

      Navigator.pushReplacementNamed(
        context,
        HOME_ROUTE,
        arguments: user,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        LOGIN_ROUTE,
      );
    }

    return;
  }

  Future<void> saveUser(User user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> logOut(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove("user");
    setUser(context, null);
    return;
  }

  Future<void> getCurrentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    User? user;
    final userJson = instance.getString("user");

    if (userJson != null) {
      user = User.fromJson(userJson);
    }

    setUser(context, user);
    return;
  }
}
