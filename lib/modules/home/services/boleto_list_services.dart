import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import 'firebase_firestore_boleto_list_services.dart';
import 'i_boleto_list_services.dart';

@Injectable(as: IBoletoListServices)
class BoletoListServices implements IBoletoListServices {
  final FirebaseFirestoreBoletoListservices _boletoListservices;

  BoletoListServices(this._boletoListservices);
  @override
  Stream<List<Boleto>> getBoletos() {
    return _boletoListservices.getBoletos();
  }
}
