import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../user/models/user.dart';
import '../services/i_auth_services.dart';

@LazySingleton()
class AuthController with ChangeNotifier {
  final IAuthServices _services;

  User? _user;

  AuthController(this._services);

  User? get user => _user;

  bool get userIsLoggedIn => _user != null;

  Future<void> saveUser(User user) async {
    final savedUser = await _services.saveUser(user);
    _user = savedUser;
    notifyListeners();
  }

  Future<void> logOut() async {
    final result = await _services.logOut();
    if (result) {
      _user = null;
    }
    notifyListeners();
  }

  Future<User?> getCurrentUser() async {
    final loggedInUser = await _services.getCurrentUser();
    _user = loggedInUser;
    return loggedInUser;
  }
}
