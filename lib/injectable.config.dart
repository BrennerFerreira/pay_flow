// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import 'modules/home/controllers/boleto_list_controller.dart' as _i16;
import 'modules/home/controllers/home_controller.dart' as _i9;
import 'modules/home/services/boleto_list_services.dart' as _i11;
import 'modules/home/services/i_boleto_list_services.dart' as _i10;
import 'modules/insert_boleto/controller/insert_boleto_controller.dart' as _i14;
import 'modules/insert_boleto/services/firebase_firestore_save_boleto_services.dart'
    as _i6;
import 'modules/insert_boleto/services/i_save_boleto_services.dart' as _i12;
import 'modules/insert_boleto/services/save_boleto_services.dart' as _i13;
import 'shared/auth/controller/auth_controller.dart' as _i20;
import 'shared/auth/services/auth_services.dart' as _i19;
import 'shared/auth/services/firebase_auth_services.dart' as _i4;
import 'shared/auth/services/firebase_firestore_services.dart' as _i7;
import 'shared/auth/services/google_services.dart' as _i17;
import 'shared/auth/services/i_auth_services.dart' as _i18;
import 'shared/third_party_modules/third_party_modules.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyModules = _$ThirdPartyModules();
  gh.factory<_i3.FirebaseAuth>(() => thirdPartyModules.auth);
  gh.factory<_i4.FirebaseAuthServices>(
      () => _i4.FirebaseAuthServices(get<_i3.FirebaseAuth>()));
  gh.factory<_i5.FirebaseFirestore>(() => thirdPartyModules.firestore);
  gh.factory<_i6.FirebaseFirestoreSaveBoletoServices>(() =>
      _i6.FirebaseFirestoreSaveBoletoServices(
          get<_i5.FirebaseFirestore>(), get<_i3.FirebaseAuth>()));
  gh.factory<_i7.FirebaseFirestoreServices>(
      () => _i7.FirebaseFirestoreServices(get<_i5.FirebaseFirestore>()));
  gh.factory<_i8.GoogleSignIn>(() => thirdPartyModules.googleSignIn);
  gh.factory<_i9.HomePageController>(() => _i9.HomePageController());
  gh.factory<_i10.IBoletoListServices>(() => _i11.BoletoListServices());
  gh.factory<_i12.ISaveBoletoServices>(() =>
      _i13.SaveBoletoServices(get<_i6.FirebaseFirestoreSaveBoletoServices>()));
  gh.factory<_i14.InsertBoletoController>(
      () => _i14.InsertBoletoController(get<_i12.ISaveBoletoServices>()));
  await gh.factoryAsync<_i15.SharedPreferences>(() => thirdPartyModules.prefs,
      preResolve: true);
  gh.factory<_i16.BoletoListController>(
      () => _i16.BoletoListController(get<_i10.IBoletoListServices>()));
  gh.factory<_i17.GoogleServices>(
      () => _i17.GoogleServices(get<_i8.GoogleSignIn>()));
  gh.factory<_i18.IAuthServices>(() => _i19.AuthServices(
      get<_i17.GoogleServices>(),
      get<_i4.FirebaseAuthServices>(),
      get<_i7.FirebaseFirestoreServices>()));
  gh.lazySingleton<_i20.AuthController>(
      () => _i20.AuthController(get<_i18.IAuthServices>()));
  return get;
}

class _$ThirdPartyModules extends _i21.ThirdPartyModules {}
