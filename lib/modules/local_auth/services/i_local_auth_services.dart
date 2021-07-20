abstract class ILocalAuthServices {
  Future<bool?> authenticate();
  Future<bool> cancelAuthentication();
}
