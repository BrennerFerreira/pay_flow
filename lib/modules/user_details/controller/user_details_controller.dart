import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../services/i_user_details_services.dart';

@injectable
class UserDetailsController with ChangeNotifier {
  final IUserDetailsServices _services;

  UserDetailsController(this._services);

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  set isDarkTheme(bool newState) {
    _isDarkTheme = newState;
    notifyListeners();
  }

  bool _useLocalAuth = false;
  bool get useLocalAuth => _useLocalAuth;
  set useLocalAuth(bool newState) {
    _useLocalAuth = newState;
    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getPreferences() async {
    _isLoading = true;
    isDarkTheme = await _services.getUserDarkThemePreference();
    useLocalAuth = await _services.useLocalAuth();
    _isLoading = false;
  }
}
