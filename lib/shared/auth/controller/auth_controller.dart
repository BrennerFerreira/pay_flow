import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../user/models/user.dart';
import '../services/i_auth_services.dart';

@LazySingleton()
class AuthController with ChangeNotifier {
  AuthController(this._services);

  final IAuthServices _services;
  User? _user;
  bool _loading = false;

  User? get user => _user;
  bool get loading => _loading;

  bool get userIsLoggedIn => _user != null;

  void _setUserLoggedIn(User? user) {
    _user = user;
    notifyListeners();
  }

  void _setLoading({required bool newState}) {
    _loading = newState;
    notifyListeners();
  }

  Future<void> googleSignIn() async {
    _setLoading(newState: true);
    User? savedUser;
    final User? user = await _services.googleSignIn();

    if (user != null) {
      savedUser = await _services.saveUser(user);

      if (savedUser == null) {
        await logOut();
      }
    }

    _user = savedUser;

    _setLoading(newState: false);
    notifyListeners();
  }

  Future<bool> logOut() async {
    _setLoading(newState: true);
    final result = await _services.logOut();

    if (result) {
      _setUserLoggedIn(null);
    }

    _setLoading(newState: false);

    return result;
  }

  User? getCurrentUser() {
    final loggedInUser = _services.getCurrentUser();
    _setUserLoggedIn(loggedInUser);
    return loggedInUser;
  }
}
