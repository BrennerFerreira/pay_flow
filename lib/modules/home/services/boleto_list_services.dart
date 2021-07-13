import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import 'firebase_firestore_boleto_list_services.dart';
import 'i_boleto_list_services.dart';

@Injectable(as: IBoletoListServices)
class BoletoListServices implements IBoletoListServices {
  final FirebaseFirestoreBoletoListservices _firebaseBoletoListservices;

  BoletoListServices(this._firebaseBoletoListservices);
  @override
  Stream<List<Boleto>> getBoletos() {
    return _firebaseBoletoListservices.getBoletos();
  }

  @override
  Future<bool> deleteBoleto(Boleto boleto) async {
    return _firebaseBoletoListservices.deleteBoleto(boleto);
  }

  @override
  Future<bool> updateBoleto(Boleto boleto) async {
    return _firebaseBoletoListservices.updateBoleto(boleto);
  }
}
