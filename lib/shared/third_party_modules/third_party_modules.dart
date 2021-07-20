import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyModules {
  FirebaseAnalytics get analytics => FirebaseAnalytics();
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: analytics);
  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  GoogleSignIn get googleSignIn => GoogleSignIn(scopes: ['email']);
  LocalAuthentication get localAuth => LocalAuthentication();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
