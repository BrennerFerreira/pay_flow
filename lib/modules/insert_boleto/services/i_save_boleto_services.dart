import '../../../shared/boleto/models/boleto.dart';

abstract class ISaveBoletoServices {
  Future<Boleto?> saveBoleto(Boleto boleto);
}
