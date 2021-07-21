import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import 'i_local_auth_services.dart';

@LazySingleton(as: ILocalAuthServices)
class LocalAuthServices implements ILocalAuthServices {
  final LocalAuthentication _localAuth;

  LocalAuthServices(this._localAuth);

  final androidMessages = const AndroidAuthMessages(
    biometricHint: "Verificar identidade",
    cancelButton: "Cancelar",
    signInTitle: "Autenticação necessária",
    goToSettingsDescription:
        "A autenticação biométrica não está configurada no seu dispositivo. Vá para "
        "'Configurações > Segurança' para adicionar uma autenticação biométrica.",
    goToSettingsButton: "Configurações",
    biometricNotRecognized: "Biometria não reconhecida",
    biometricSuccess: "Autenticação bem-sucedida",
    biometricRequiredTitle: "Autenticação biomética necessária",
    deviceCredentialsRequiredTitle: "Credenciais do dispositivo necessárias",
    deviceCredentialsSetupDescription:
        "Configure as credenciais do dispositivo",
  );
  final iosMessages = const IOSAuthMessages(
    goToSettingsDescription:
        "A autenticação biométrica não está configurada no seu dispositivo. Vá para "
        "'Configurações > Segurança' para adicionar uma autenticação biométrica.",
    lockOut:
        'Autenticação biométrica está desabilitada. Por favor, bloqueie e desbloqueie sua tela para '
        'habilitá-la.',
    cancelButton: "Cancelar",
    goToSettingsButton: "Ir para as configurações",
  );

  @override
  Future<bool?> authenticate() async {
    try {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;

      if (!canCheckBiometrics) {
        return null;
      }

      final List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        return null;
      }

      final bool authenticated = await _localAuth.authenticate(
        localizedReason: "Desbloqueie seu app.",
        biometricOnly: true,
        stickyAuth: true,
        androidAuthStrings: androidMessages,
        iOSAuthStrings: iosMessages,
      );

      return authenticated;
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<bool> cancelAuthentication() async {
    return _localAuth.stopAuthentication();
  }
}
