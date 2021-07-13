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

  DocumentReference<Map<String, dynamic>> _getUserDoc() {
    final userId = _auth.currentUser!.uid;

    final userDoc = _firestore.collection(USERS_STRING).doc(userId);

    return userDoc;
  }

  Future<List<Boleto>?> _getUserSavedBoletos() async {
    try {
      final userDoc = _getUserDoc();

      final userDocData = await userDoc.get();

      final userData = userDocData.data()!;

      final oldBoletosListMap = List.castFrom<dynamic, Map<String, dynamic>>(
          userData[BOLETOS_STRING] as List);

      final boletosList = oldBoletosListMap.map((e) {
        return Boleto.fromMap(e);
      }).toList();

      return boletosList;
    } catch (e) {
      return null;
    }
  }

  Stream<List<Boleto>> getBoletos() {
    final userDoc = _getUserDoc();

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

  Future<bool> deleteBoleto(Boleto boleto) async {
    try {
      final userDoc = _getUserDoc();

      final boletosList = await _getUserSavedBoletos();

      if (boletosList == null) {
        return false;
      }

      boletosList.remove(boleto);

      final newBoletosListMap = boletosList.map((e) => e.toMap()).toList();

      await userDoc.set(
        {
          BOLETOS_STRING: newBoletosListMap,
        },
        SetOptions(merge: true),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBoleto(Boleto boleto) async {
    try {
      final userDoc = _getUserDoc();

      final boletosList = await _getUserSavedBoletos();

      if (boletosList == null) {
        return false;
      }

      bool idMatcher(element) => element.id == boleto.id;

      final boletoToUpdateIndex = boletosList.indexWhere(idMatcher);

      boletosList.replaceRange(
        boletoToUpdateIndex,
        boletoToUpdateIndex + 1,
        [boleto],
      );

      final newBoletosListMap = boletosList.map((e) => e.toMap()).toList();

      await userDoc.set(
        {
          BOLETOS_STRING: newBoletosListMap,
        },
        SetOptions(merge: true),
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
