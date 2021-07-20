import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../services/i_user_details_services.dart';

@injectable
class UserDetailsController with ChangeNotifier {
  final IUserDetailsServices _services;

  UserDetailsController(this._services) {
    getPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  set isDarkTheme(bool newState) {
    _isDarkTheme = newState;
    notifyListeners();
  }

  Future<void> getPreferences() async {
    isDarkTheme = await _services.getUserDarkThemePreference();
  }
}
