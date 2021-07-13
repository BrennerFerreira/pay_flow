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

  Stream<List<Boleto>> _getPaidOrUnpaidBoletos({bool paid = true}) {
    final allBoletos = getBoletos();

    final paidBoletos = allBoletos.map<List<Boleto>>(
      (event) => event
          .where(
            (element) => paid ? element.paid : !element.paid,
          )
          .toList(),
    );

    return paidBoletos;
  }

  Stream<List<Boleto>> getPaidBoletos() {
    final paidBoletos = _getPaidOrUnpaidBoletos();

    final sortedList = paidBoletos.map<List<Boleto>>(
      (event) {
        event.sort((a, b) => b.dueDate.compareTo(a.dueDate));
        return event;
      },
    );

    return sortedList;
  }

  Stream<List<Boleto>> getUnpaidBoletos() {
    return _getPaidOrUnpaidBoletos(paid: false);
  }

  Stream<int> paidBoletosLength() {
    return getPaidBoletos().map((event) => event.length);
  }

  Stream<int> unpaidBoletosLength() {
    return getUnpaidBoletos().map((event) => event.length);
  }

  Future<bool> deleteBoleto(Boleto boleto) async {
    _setIsLoading(newState: true);
    final result = await _services.deleteBoleto(boleto);
    _setIsLoading(newState: false);
    return result;
  }

  Future<bool> updateBoletoPaid(Boleto boleto) async {
    _setIsLoading(newState: true);
    final updatedBoleto = boleto.copyWith(paid: true, paidAt: DateTime.now());
    final result = await _services.updateBoleto(updatedBoleto);
    _setIsLoading(newState: false);
    return result;
  }
}
