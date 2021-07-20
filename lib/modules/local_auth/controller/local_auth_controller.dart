import 'package:boleto_organizer/modules/local_auth/services/i_local_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> authenticationRequested() async {
    final authenticationSuccess = await _services.authenticate();

    if (authenticationSuccess == null) {
      await _services.cancelAuthentication();
      _authFail = true;
    } else {
      _authFail = !authenticationSuccess;
      _isAuthenticated = authenticationSuccess;
    }

    _isLoading = false;
    notifyListeners();
    return;
  }
}
