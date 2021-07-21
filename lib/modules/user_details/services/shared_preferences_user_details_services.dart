import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/constants/constants.dart';
import 'i_user_details_services.dart';

@Injectable(as: IUserDetailsServices)
class SharedPreferencesUserDetailsServices implements IUserDetailsServices {
  final SharedPreferences _prefs;

  SharedPreferencesUserDetailsServices(this._prefs);

  @override
  Future<bool> useLocalAuth() async {
    final useLocalAuth = _prefs.getBool(LOCAL_AUTH_STRING) ?? false;

    return useLocalAuth;
  }

  @override
  Future<bool> setUseLocalAuth({required bool newValue}) async {
    final result = await _prefs.setBool(LOCAL_AUTH_STRING, newValue);

    return result;
  }
}
