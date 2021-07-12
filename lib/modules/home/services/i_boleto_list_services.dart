import '../../../shared/boleto/models/boleto.dart';

abstract class IBoletoListServices {
  Stream<List<Boleto>> getBoletos();

  Future<bool> deleteBoleto(Boleto boleto);
}
