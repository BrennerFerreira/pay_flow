import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../services/i_save_boleto_services.dart';
import '../services/validate_services.dart';

@injectable
class InsertBoletoController with ChangeNotifier {
  InsertBoletoController(this._services);

  final formKey = GlobalKey<FormState>();

  Boleto _boleto = Boleto.empty();
  bool _error = false;
  bool _isLoading = false;
  bool _updatePrice = false;
  final ISaveBoletoServices _services;
  final _validateServices = ValidateServices();

  bool get isLoading => _isLoading;

  bool get error => _error;

  bool get updatePrice => _updatePrice;

  void _setIsLoading({required bool newState}) {
    _isLoading = newState;
    notifyListeners();
  }

  void _setError({required bool newState}) {
    _error = newState;
    notifyListeners();
  }

  void _setUpdatePrice({required bool newState}) {
    _updatePrice = newState;
    notifyListeners();
  }

  Boleto get boleto => _boleto;

  void setBoletoBarCode(String barCode) {
    _boleto = Boleto.fromBarCode(barCode);
    _setUpdatePrice(newState: true);
    notifyListeners();
  }

  String? validateName() => _validateServices.validateName(_boleto.name);

  String? validatePrice() => _validateServices.validatePrice(_boleto.price);

  String? validateBarCode() =>
      _validateServices.validateBarCode(_boleto.barCode);

  void onChange({
    String? name,
    DateTime? dueDate,
    double? price,
    String? barCode,
  }) {
    _setError(newState: false);
    _boleto = _boleto.copyWith(
      name: name,
      dueDate: dueDate,
      price: price,
      barCode: barCode,
    );
    notifyListeners();
  }

  void onBarCodeChange(String? barCode) {
    _setError(newState: false);
    _boleto = _boleto.copyWith(barCode: barCode);

    if (barCode != null &&
        barCode.replaceAll(RegExp("[^0-9]"), "").length == 47) {
      setBoletoBarCode(barCode);
    }
  }

  Future<Boleto?> submitBoleto() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      _setIsLoading(newState: true);
      final savedBoleto = await _services.saveBoleto(boleto);
      return savedBoleto;
    }
  }
}
