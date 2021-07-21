import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../services/i_user_details_services.dart';

class UserPreferences {
  bool useLocalAuth;

  UserPreferences({
    required this.useLocalAuth,
  });
}

@injectable
class UserDetailsController with ChangeNotifier {
  final IUserDetailsServices _services;

  UserDetailsController(this._services);

  bool _useLocalAuth = false;
  bool get useLocalAuth => _useLocalAuth;
  set useLocalAuth(bool newState) {
    _useLocalAuth = newState;
    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<UserPreferences> getPreferences() async {
    _isLoading = true;
    useLocalAuth = await _services.useLocalAuth();
    _isLoading = false;

    return UserPreferences(
      useLocalAuth: _useLocalAuth,
    );
  }

  Future<void> setUseLocalAuth({required bool newValue}) async {
    final result = await _services.setUseLocalAuth(newValue: newValue);

    if (result) {
      useLocalAuth = newValue;
    }

    notifyListeners();
  }
}
