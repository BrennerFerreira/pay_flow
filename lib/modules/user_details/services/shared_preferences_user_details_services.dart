import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/constants/constants.dart';
import 'i_user_details_services.dart';

@Injectable(as: IUserDetailsServices)
class SharedPreferencesUserDetailsServices implements IUserDetailsServices {
  final SharedPreferences _prefs;

  SharedPreferencesUserDetailsServices(this._prefs);

  @override
  Future<bool> getUserDarkThemePreference() async {
    final darkThemePreference = _prefs.getBool(DARK_THEME_STRING) ??
        (SchedulerBinding.instance?.window.platformBrightness ??
                Brightness.light) ==
            Brightness.dark;

    return darkThemePreference;
  }

  @override
  Future<bool> useLocalAuth() async {
    final useLocalAuth = _prefs.getBool(LOCAL_AUTH_STRING) ?? false;

    return useLocalAuth;
  }
}
