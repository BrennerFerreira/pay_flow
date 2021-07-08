// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'modules/login/controller/login_controller.dart' as _i6;
import 'modules/login/services/google_sign_in_module.dart' as _i11;
import 'modules/login/services/i_login_services.dart' as _i4;
import 'modules/login/services/login_services.dart' as _i5;
import 'shared/auth/controller/auth_controller.dart' as _i10;
import 'shared/auth/services/auth_services.dart' as _i9;
import 'shared/auth/services/i_auth_services.dart' as _i8;
import 'shared/auth/services/shared_preferences_module.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final googleSignInModule = _$GoogleSignInModule();
  final sharedPreferencesModule = _$SharedPreferencesModule();
  gh.factory<_i3.GoogleSignIn>(() => googleSignInModule.googleSignIn);
  gh.factory<_i4.ILoginServices>(
      () => _i5.LoginServices(get<_i3.GoogleSignIn>()));
  gh.factory<_i6.LoginController>(
      () => _i6.LoginController(get<_i4.ILoginServices>()));
  await gh.factoryAsync<_i7.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true);
  gh.factory<_i8.IAuthServices>(
      () => _i9.AuthServices(get<_i7.SharedPreferences>()));
  gh.lazySingleton<_i10.AuthController>(
      () => _i10.AuthController(get<_i8.IAuthServices>()));
  return get;
}

class _$GoogleSignInModule extends _i11.GoogleSignInModule {}

class _$SharedPreferencesModule extends _i12.SharedPreferencesModule {}
