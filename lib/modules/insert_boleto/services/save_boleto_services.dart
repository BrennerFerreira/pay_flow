import 'package:boleto_organizer/injectable.dart';
import 'package:boleto_organizer/modules/insert_boleto/services/i_save_boleto_services.dart';
import 'package:boleto_organizer/shared/boleto/models/boleto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
