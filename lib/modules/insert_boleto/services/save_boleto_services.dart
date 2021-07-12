import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import 'firebase_firestore_save_boleto_services.dart';
import 'i_save_boleto_services.dart';

@Injectable(as: ISaveBoletoServices)
class SaveBoletoServices implements ISaveBoletoServices {
  final FirebaseFirestoreSaveBoletoServices _saveBoletoServices;

  SaveBoletoServices(this._saveBoletoServices);
  @override
  Future<Boleto?> saveBoleto(Boleto boleto) async {
    final savedBoleto = await _saveBoletoServices.saveBoleto(boleto);

    return savedBoleto;
  }
}
