abstract class IUserDetailsServices {
  Future<bool> useLocalAuth();
  Future<bool> setUseLocalAuth({required bool newValue});
}
