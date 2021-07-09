// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import 'shared/auth/controller/auth_controller.dart' as _i7;
import 'shared/auth/services/auth_services.dart' as _i6;
import 'shared/auth/services/i_auth_services.dart' as _i5;
import 'shared/auth/services/modules/google_sign_in_module.dart' as _i8;
import 'shared/auth/services/modules/shared_preferences_module.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final googleSignInModule = _$GoogleSignInModule();
  final sharedPreferencesModule = _$SharedPreferencesModule();
  gh.factory<_i3.GoogleSignIn>(() => googleSignInModule.googleSignIn);
  await gh.factoryAsync<_i4.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true);
  gh.factory<_i5.IAuthServices>(() =>
      _i6.AuthServices(get<_i4.SharedPreferences>(), get<_i3.GoogleSignIn>()));
  gh.lazySingleton<_i7.AuthController>(
      () => _i7.AuthController(get<_i5.IAuthServices>()));
  return get;
}

class _$GoogleSignInModule extends _i8.GoogleSignInModule {}

class _$SharedPreferencesModule extends _i9.SharedPreferencesModule {}
