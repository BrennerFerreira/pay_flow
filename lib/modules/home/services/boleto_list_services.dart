import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injectable.dart';
import '../../../shared/boleto/models/boleto.dart';
import 'i_boleto_list_services.dart';

@Injectable(as: IBoletoListServices)
class BoletoListServices implements IBoletoListServices {
  @override
  Future<List<Boleto>> getBoletos() async {
    // try {
    //   final instance = getIt<SharedPreferences>();

    //   final response = instance.getStringList("boletos") ?? <String>[];

    //   final boletos =
    //       response.map((boletoJson) => Boleto.fromJson(boletoJson)).toList();

    //   return boletos;
    // } catch (error) {
    //   return [];
    // }
    final List<Boleto> boletos = [
      Boleto(
        barCode: "1234567895132165",
        dueDate: "12/12/1245",
        name: "Teste",
        price: 123.65,
      ),
      Boleto(
        barCode: "1234567895132165",
        dueDate: "12/12/1245",
        name: "Teste",
        price: 123.65,
      ),
      Boleto(
        barCode: "1234567895132165",
        dueDate: "12/12/1245",
        name: "Teste",
        price: 123.65,
      ),
      Boleto(
        barCode: "1234567895132165",
        dueDate: "12/12/1245",
        name: "Teste",
        price: 123.65,
      ),
    ];

    return Future.value(boletos);
  }
}
