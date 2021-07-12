import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injectable.dart';
import '../../../shared/boleto/models/boleto.dart';
import 'i_save_boleto_services.dart';

@Injectable(as: ISaveBoletoServices)
class SaveBoletoServices implements ISaveBoletoServices {
  @override
  Future<Boleto?> saveBoleto(Boleto boleto) async {
    try {
      final instance = getIt<SharedPreferences>();
      final boletos = instance.getStringList("boletos") ?? <String>[];
      boletos.add(boleto.toJson());
      await instance.setStringList("boletos", boletos);
      return boleto;
    } catch (_) {
      return null;
    }
  }
}
