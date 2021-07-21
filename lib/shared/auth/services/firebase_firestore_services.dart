import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../constants/constants.dart';
import '../../user/models/user.dart';

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
          {
            CREATED_AT_STRING: DateTime.now().millisecondsSinceEpoch,
            EMAIL_STRING: user.email,
          },
        );
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveToken({
    required String userId,
    required String token,
  }) async {
    try {
      final tokenData = {
        TOKEN_TITLE_STRING: token,
        UPDATED_AT_STRING: DateTime.now().millisecondsSinceEpoch,
        PLATFORM_STRING: Platform.operatingSystem,
      };

      final userDoc = _firestore.collection(USERS_STRING).doc(userId);

      final userDocData = await userDoc.get();

      if (userDocData.data()!.containsKey(TOKENS_STRING)) {
        final tokens = List.castFrom<dynamic, Map<String, dynamic>>(
          userDocData.data()![TOKENS_STRING] as List<dynamic>,
        );

        final sameTokenExists = tokens
            .where(
              (element) => element[TOKEN_TITLE_STRING] as String == token,
            )
            .toList();

        if (sameTokenExists.isEmpty) {
          userDoc.set(
            {
              TOKENS_STRING: FieldValue.arrayUnion([tokenData])
            },
            SetOptions(merge: true),
          );
        } else {
          userDoc.set(
            {
              TOKENS_STRING: FieldValue.arrayRemove(sameTokenExists),
            },
            SetOptions(merge: true),
          );

          userDoc.set(
            {
              TOKENS_STRING: FieldValue.arrayUnion([tokenData]),
            },
            SetOptions(merge: true),
          );
        }
      } else {
        userDoc.set(
          {
            TOKENS_STRING: [tokenData],
          },
          SetOptions(merge: true),
        );
      }
    } catch (e) {
      return;
    }
  }

  Future<bool?> deleteUserDoc(String userId) async {
    try {
      await _firestore.collection(USERS_STRING).doc(userId).delete();

      return true;
    } on FirebaseException {
      return false;
    }
  }
}
