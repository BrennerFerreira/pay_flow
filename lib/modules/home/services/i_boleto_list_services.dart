import '../../../shared/boleto/models/boleto.dart';

abstract class IBoletoListServices {
  Future<List<Boleto>> getBoletos();
}
