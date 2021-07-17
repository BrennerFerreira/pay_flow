// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:firebase_analytics/firebase_analytics.dart' as _i3;
import 'package:firebase_analytics/observer.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_messaging/firebase_messaging.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i12;
import 'package:injectable/injectable.dart' as _i2;

import 'modules/home/controllers/boleto_list_controller.dart' as _i21;
import 'modules/home/controllers/home_controller.dart' as _i27;
import 'modules/home/services/boleto_list_services.dart' as _i16;
import 'modules/home/services/firebase_firestore_boleto_list_services.dart'
    as _i8;
import 'modules/home/services/i_boleto_list_services.dart' as _i15;
import 'modules/insert_boleto/controller/insert_boleto_controller.dart' as _i19;
import 'modules/insert_boleto/services/firebase_firestore_save_boleto_services.dart'
    as _i9;
import 'modules/insert_boleto/services/i_save_boleto_services.dart' as _i17;
import 'modules/insert_boleto/services/save_boleto_services.dart' as _i18;
import 'shared/analytics/controller/analytics_controller.dart' as _i20;
import 'shared/analytics/services/firebase_analytics_services.dart' as _i14;
import 'shared/analytics/services/i_analytics_services.dart' as _i13;
import 'shared/auth/controller/auth_controller.dart' as _i26;
import 'shared/auth/services/auth_services.dart' as _i25;
import 'shared/auth/services/firebase_auth_services.dart' as _i6;
import 'shared/auth/services/firebase_firestore_services.dart' as _i10;
import 'shared/auth/services/firebase_messaging_services.dart' as _i22;
import 'shared/auth/services/google_services.dart' as _i23;
import 'shared/auth/services/i_auth_services.dart' as _i24;
import 'shared/third_party_modules/third_party_modules.dart'
    as _i28; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyModules = _$ThirdPartyModules();
  gh.factory<_i3.FirebaseAnalytics>(() => thirdPartyModules.analytics);
  gh.factory<_i4.FirebaseAnalyticsObserver>(() => thirdPartyModules.observer);
  gh.factory<_i5.FirebaseAuth>(() => thirdPartyModules.auth);
  gh.factory<_i6.FirebaseAuthServices>(
      () => _i6.FirebaseAuthServices(get<_i5.FirebaseAuth>()));
  gh.factory<_i7.FirebaseFirestore>(() => thirdPartyModules.firestore);
  gh.factory<_i8.FirebaseFirestoreBoletoListservices>(() =>
      _i8.FirebaseFirestoreBoletoListservices(
          get<_i5.FirebaseAuth>(), get<_i7.FirebaseFirestore>()));
  gh.factory<_i9.FirebaseFirestoreSaveBoletoServices>(() =>
      _i9.FirebaseFirestoreSaveBoletoServices(
          get<_i7.FirebaseFirestore>(), get<_i5.FirebaseAuth>()));
  gh.factory<_i10.FirebaseFirestoreServices>(
      () => _i10.FirebaseFirestoreServices(get<_i7.FirebaseFirestore>()));
  gh.factory<_i11.FirebaseMessaging>(() => thirdPartyModules.firebaseMessaging);
  gh.factory<_i12.GoogleSignIn>(() => thirdPartyModules.googleSignIn);
  gh.factory<_i13.IAnalyticsServices>(() =>
      _i14.FirebaseAnalyticsServices(get<_i4.FirebaseAnalyticsObserver>()));
  gh.factory<_i15.IBoletoListServices>(() =>
      _i16.BoletoListServices(get<_i8.FirebaseFirestoreBoletoListservices>()));
  gh.factory<_i17.ISaveBoletoServices>(() =>
      _i18.SaveBoletoServices(get<_i9.FirebaseFirestoreSaveBoletoServices>()));
  gh.factory<_i19.InsertBoletoController>(
      () => _i19.InsertBoletoController(get<_i17.ISaveBoletoServices>()));
  gh.factory<_i20.AnalyticsController>(
      () => _i20.AnalyticsController(get<_i13.IAnalyticsServices>()));
  gh.factory<_i21.BoletoListController>(
      () => _i21.BoletoListController(get<_i15.IBoletoListServices>()));
  gh.factory<_i22.FirebaseMessaginServices>(
      () => _i22.FirebaseMessaginServices(get<_i11.FirebaseMessaging>()));
  gh.factory<_i23.GoogleServices>(
      () => _i23.GoogleServices(get<_i12.GoogleSignIn>()));
  gh.factory<_i24.IAuthServices>(() => _i25.AuthServices(
      get<_i23.GoogleServices>(),
      get<_i6.FirebaseAuthServices>(),
      get<_i10.FirebaseFirestoreServices>(),
      get<_i22.FirebaseMessaginServices>()));
  gh.lazySingleton<_i26.AuthController>(
      () => _i26.AuthController(get<_i24.IAuthServices>()));
  gh.factory<_i27.HomePageController>(
      () => _i27.HomePageController(get<_i26.AuthController>()));
  return get;
}

class _$ThirdPartyModules extends _i28.ThirdPartyModules {}
