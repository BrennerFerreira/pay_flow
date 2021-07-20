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
import 'package:shared_preferences/shared_preferences.dart' as _i20;

import 'modules/home/controllers/boleto_list_controller.dart' as _i22;
import 'modules/home/controllers/home_controller.dart' as _i31;
import 'modules/home/services/boleto_list_services.dart' as _i16;
import 'modules/home/services/firebase_firestore_boleto_list_services.dart'
    as _i8;
import 'modules/home/services/i_boleto_list_services.dart' as _i15;
import 'modules/insert_boleto/controller/insert_boleto_controller.dart' as _i19;
import 'modules/insert_boleto/services/firebase_firestore_save_boleto_services.dart'
    as _i9;
import 'modules/insert_boleto/services/i_save_boleto_services.dart' as _i17;
import 'modules/insert_boleto/services/save_boleto_services.dart' as _i18;
import 'modules/user_details/controller/user_details_controller.dart' as _i29;
import 'modules/user_details/services/i_user_details_services.dart' as _i27;
import 'modules/user_details/services/shared_preferences_user_details_services.dart'
    as _i28;
import 'shared/analytics/controller/analytics_controller.dart' as _i21;
import 'shared/analytics/services/firebase_analytics_services.dart' as _i14;
import 'shared/analytics/services/i_analytics_services.dart' as _i13;
import 'shared/auth/controller/auth_controller.dart' as _i30;
import 'shared/auth/services/auth_services.dart' as _i26;
import 'shared/auth/services/firebase_auth_services.dart' as _i6;
import 'shared/auth/services/firebase_firestore_services.dart' as _i10;
import 'shared/auth/services/firebase_messaging_services.dart' as _i23;
import 'shared/auth/services/google_services.dart' as _i24;
import 'shared/auth/services/i_auth_services.dart' as _i25;
import 'shared/third_party_modules/third_party_modules.dart'
    as _i32; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
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
  await gh.factoryAsync<_i20.SharedPreferences>(() => thirdPartyModules.prefs,
      preResolve: true);
  gh.factory<_i21.AnalyticsController>(
      () => _i21.AnalyticsController(get<_i13.IAnalyticsServices>()));
  gh.factory<_i22.BoletoListController>(
      () => _i22.BoletoListController(get<_i15.IBoletoListServices>()));
  gh.factory<_i23.FirebaseMessaginServices>(
      () => _i23.FirebaseMessaginServices(get<_i11.FirebaseMessaging>()));
  gh.factory<_i24.GoogleServices>(
      () => _i24.GoogleServices(get<_i12.GoogleSignIn>()));
  gh.factory<_i25.IAuthServices>(() => _i26.AuthServices(
      get<_i24.GoogleServices>(),
      get<_i6.FirebaseAuthServices>(),
      get<_i10.FirebaseFirestoreServices>(),
      get<_i23.FirebaseMessaginServices>()));
  gh.factory<_i27.IUserDetailsServices>(() =>
      _i28.SharedPreferencesUserDetailsServices(get<_i20.SharedPreferences>()));
  gh.factory<_i29.UserDetailsController>(
      () => _i29.UserDetailsController(get<_i27.IUserDetailsServices>()));
  gh.lazySingleton<_i30.AuthController>(
      () => _i30.AuthController(get<_i25.IAuthServices>()));
  gh.factory<_i31.HomePageController>(
      () => _i31.HomePageController(get<_i30.AuthController>()));
  return get;
}

class _$ThirdPartyModules extends _i32.ThirdPartyModules {}
