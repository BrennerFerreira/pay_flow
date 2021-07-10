import 'package:boleto_organizer/shared/boleto/models/boleto.dart';

abstract class IBoletoListServices {
  Future<List<Boleto>> getBoletos();
}
