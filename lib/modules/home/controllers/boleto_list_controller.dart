import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/boleto/models/boleto.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<Boleto>>([]);
  List<Boleto> get boletos => boletosNotifier.value;
  set boletos(List<Boleto> value) => boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();

      final response = instance.getStringList("boletos") ?? <String>[];

      boletos = response
          .map(
            (boletoJson) => Boleto.fromJson(boletoJson),
          )
          .toList();
    } catch (error) {
      print(error);
    }
  }
}
