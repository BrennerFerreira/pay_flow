import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../services/i_boleto_list_services.dart';

@injectable
class BoletoListController with ChangeNotifier {
  final IBoletoListServices _services;

  BoletoListController(this._services) {
    getBoletos();
  }

  List<Boleto> _boletos = [];

  List<Boleto> get boletos => _boletos;

  Future<void> getBoletos() async {
    _boletos = await _services.getBoletos();
    notifyListeners();
  }
}
