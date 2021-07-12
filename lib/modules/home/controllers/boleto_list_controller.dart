import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../services/i_boleto_list_services.dart';

@injectable
class BoletoListController with ChangeNotifier {
  final IBoletoListServices _services;

  BoletoListController(this._services);

  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  // void _setIsLoading({required bool newState}) {
  //   _isLoading = newState;
  //   notifyListeners();
  // }

  Stream<List<Boleto>> getBoletos() {
    return _services.getBoletos();
  }

  Stream<int> boletosLength() {
    return getBoletos().map((event) => event.length);
  }
}
