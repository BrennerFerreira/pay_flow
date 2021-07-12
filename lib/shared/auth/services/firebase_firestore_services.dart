import 'package:boleto_organizer/shared/constants/constants.dart';
import 'package:boleto_organizer/shared/user/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseFirestoreServices {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreServices(this._firestore);

  Future<User?> saveUser(User user) async {
    try {
      final document = _firestore.collection(USERS_STRING).doc(user.id);

      final userData = await document.get();

      if (!userData.exists) {
        await _firestore.collection(USERS_STRING).doc(user.id).set(
              user.toMap(),
              SetOptions(merge: true),
            );
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> getUserMap(String userId) async {
    try {
      final loggedInUserDoc =
          await _firestore.collection(USERS_STRING).doc(userId).get();

      final loggedInUserMap = loggedInUserDoc.data()!;

      final user = User.fromMap(loggedInUserMap);

      return user;
    } catch (e) {
      return null;
    }
  }
}
