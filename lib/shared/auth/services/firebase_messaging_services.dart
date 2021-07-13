import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseMessaginServices {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseMessaginServices(this._firebaseMessaging);

  Future<String?> getUserToken() async {
    try {
      final String? token = await _firebaseMessaging.getToken();

      return token;
    } catch (e) {
      return null;
    }
  }
}
