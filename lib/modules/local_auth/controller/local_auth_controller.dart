import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../services/i_local_auth_services.dart';

@injectable
class LocalAuthController with ChangeNotifier {
  final ILocalAuthServices _services;

  LocalAuthController(this._services);

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool _authFail = false;
  bool get authFail => _authFail;
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> authenticationRequested() async {
    final authenticationResponse = await _services.authenticate();

    if (authenticationResponse == null) {
      _isLoading = false;
      notifyListeners();
      return true;
    }

    if (!authenticationResponse) {
      await _services.cancelAuthentication();
      _authFail = true;
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _authFail = !authenticationResponse;
    _isAuthenticated = authenticationResponse;
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
