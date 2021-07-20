abstract class IUserDetailsServices {
  Future<bool> getUserDarkThemePreference();
  Future<bool> useLocalAuth();
  Future<bool> setUseLocalAuth({required bool newValue});
}
