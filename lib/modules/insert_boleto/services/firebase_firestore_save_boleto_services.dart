import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../../../shared/constants/constants.dart';

@injectable
class FirebaseFirestoreSaveBoletoServices {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseFirestoreSaveBoletoServices(this._firestore, this._auth);

  Future<Boleto?> saveBoleto(Boleto boleto) async {
    try {
      final userId = _auth.currentUser!.uid;

      final userDoc = _firestore.collection(USERS_STRING).doc(userId);

      final userData = await userDoc.get();

      if (userData.data()!.containsKey(BOLETOS_STRING)) {
        await userDoc.update(
          {
            BOLETOS_STRING: FieldValue.arrayUnion(
              [boleto.toMap()],
            ),
          },
        );
      } else {
        userDoc.set(
          {
            BOLETOS_STRING: [boleto.toMap()],
          },
          SetOptions(merge: true),
        );
      }

      return boleto;
    } catch (error) {
      return null;
    }
  }
}
