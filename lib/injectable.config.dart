// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_messaging/firebase_messaging.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;

import 'modules/home/controllers/boleto_list_controller.dart' as _i17;
import 'modules/home/controllers/home_controller.dart' as _i11;
import 'modules/home/services/boleto_list_services.dart' as _i13;
import 'modules/home/services/firebase_firestore_boleto_list_services.dart'
    as _i6;
import 'modules/home/services/i_boleto_list_services.dart' as _i12;
import 'modules/insert_boleto/controller/insert_boleto_controller.dart' as _i16;
import 'modules/insert_boleto/services/firebase_firestore_save_boleto_services.dart'
    as _i7;
import 'modules/insert_boleto/services/i_save_boleto_services.dart' as _i14;
import 'modules/insert_boleto/services/save_boleto_services.dart' as _i15;
import 'shared/auth/controller/auth_controller.dart' as _i22;
import 'shared/auth/services/auth_services.dart' as _i21;
import 'shared/auth/services/firebase_auth_services.dart' as _i4;
import 'shared/auth/services/firebase_firestore_services.dart' as _i8;
import 'shared/auth/services/firebase_messaging_services.dart' as _i18;
import 'shared/auth/services/google_services.dart' as _i19;
import 'shared/auth/services/i_auth_services.dart' as _i20;
import 'shared/third_party_modules/third_party_modules.dart'
    as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyModules = _$ThirdPartyModules();
  gh.factory<_i3.FirebaseAuth>(() => thirdPartyModules.auth);
  gh.factory<_i4.FirebaseAuthServices>(
      () => _i4.FirebaseAuthServices(get<_i3.FirebaseAuth>()));
  gh.factory<_i5.FirebaseFirestore>(() => thirdPartyModules.firestore);
  gh.factory<_i6.FirebaseFirestoreBoletoListservices>(() =>
      _i6.FirebaseFirestoreBoletoListservices(
          get<_i3.FirebaseAuth>(), get<_i5.FirebaseFirestore>()));
  gh.factory<_i7.FirebaseFirestoreSaveBoletoServices>(() =>
      _i7.FirebaseFirestoreSaveBoletoServices(
          get<_i5.FirebaseFirestore>(), get<_i3.FirebaseAuth>()));
  gh.factory<_i8.FirebaseFirestoreServices>(
      () => _i8.FirebaseFirestoreServices(get<_i5.FirebaseFirestore>()));
  gh.factory<_i9.FirebaseMessaging>(() => thirdPartyModules.firebaseMessaging);
  gh.factory<_i10.GoogleSignIn>(() => thirdPartyModules.googleSignIn);
  gh.factory<_i11.HomePageController>(() => _i11.HomePageController());
  gh.factory<_i12.IBoletoListServices>(() =>
      _i13.BoletoListServices(get<_i6.FirebaseFirestoreBoletoListservices>()));
  gh.factory<_i14.ISaveBoletoServices>(() =>
      _i15.SaveBoletoServices(get<_i7.FirebaseFirestoreSaveBoletoServices>()));
  gh.factory<_i16.InsertBoletoController>(
      () => _i16.InsertBoletoController(get<_i14.ISaveBoletoServices>()));
  gh.factory<_i17.BoletoListController>(
      () => _i17.BoletoListController(get<_i12.IBoletoListServices>()));
  gh.factory<_i18.FirebaseMessaginServices>(
      () => _i18.FirebaseMessaginServices(get<_i9.FirebaseMessaging>()));
  gh.factory<_i19.GoogleServices>(
      () => _i19.GoogleServices(get<_i10.GoogleSignIn>()));
  gh.factory<_i20.IAuthServices>(() => _i21.AuthServices(
      get<_i19.GoogleServices>(),
      get<_i4.FirebaseAuthServices>(),
      get<_i8.FirebaseFirestoreServices>(),
      get<_i18.FirebaseMessaginServices>()));
  gh.lazySingleton<_i22.AuthController>(
      () => _i22.AuthController(get<_i20.IAuthServices>()));
  return get;
}

class _$ThirdPartyModules extends _i23.ThirdPartyModules {}
