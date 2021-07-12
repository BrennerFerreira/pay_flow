import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../../../shared/constants/constants.dart';

@injectable
class FirebaseFirestoreBoletoListservices {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseFirestoreBoletoListservices(this._auth, this._firestore);

  Stream<List<Boleto>> getBoletos() {
    final userId = _auth.currentUser!.uid;

    final userDoc = _firestore.collection(USERS_STRING).doc(userId);

    final userDocSnapshot = userDoc.snapshots();

    final userDocBoletos = userDocSnapshot.map<List<Boleto>>(
      (event) {
        final eventData = event.data()!;

        final boletos = List.castFrom<dynamic, Map<String, dynamic>>(
            (eventData[BOLETOS_STRING] as List?) ?? []);

        final boletosList = boletos.map((e) => Boleto.fromMap(e)).toList();

        return boletosList;
      },
    );

    return userDocBoletos;
  }
}
