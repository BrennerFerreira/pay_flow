import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../services/i_boleto_list_services.dart';

@injectable
class BoletoListController with ChangeNotifier {
  final IBoletoListServices _services;

  BoletoListController(this._services);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _setIsLoading({required bool newState}) {
    _isLoading = newState;
    notifyListeners();
  }

  Stream<List<Boleto>> getBoletos() {
    return _services.getBoletos();
  }

  Stream<int> boletosLength() {
    return getBoletos().map((event) => event.length);
  }

  Future<bool> deleteBoleto(Boleto boleto) async {
    _setIsLoading(newState: true);
    final result = await _services.deleteBoleto(boleto);
    _setIsLoading(newState: false);
    return result;
  }

  Future<bool> updateBoletoPaid(Boleto boleto, {required bool isPaid}) async {
    _setIsLoading(newState: true);
    final updatedBoleto = boleto.copyWith(paid: isPaid);
    final result = await _services.updateBoleto(updatedBoleto);
    _setIsLoading(newState: false);
    return result;
  }
}
