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

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void _setIsLoading({required bool newState}) {
    _isLoading = newState;
    notifyListeners();
  }

  List<Boleto> _boletos = [];

  List<Boleto> get boletos => _boletos;

  Future<void> getBoletos() async {
    _setIsLoading(newState: true);
    _boletos = await _services.getBoletos();
    _setIsLoading(newState: false);
  }
}
