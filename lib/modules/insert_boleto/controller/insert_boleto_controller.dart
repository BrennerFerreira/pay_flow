import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../services/i_save_boleto_services.dart';
import '../services/validate_services.dart';

@injectable
class InsertBoletoController with ChangeNotifier {
  final ISaveBoletoServices _services;

  InsertBoletoController(this._services);

  bool _isLoading = false;
  bool _error = false;

  bool get isLoading => _isLoading;
  bool get error => _error;

  void _setIsLoading({required bool newState}) {
    _isLoading = newState;
    notifyListeners();
  }

  void _setError({required bool newState}) {
    _error = newState;
    notifyListeners();
  }

  final _validateServices = ValidateServices();
  Boleto _boleto = Boleto.empty();

  Boleto get boleto => _boleto;
  final formKey = GlobalKey<FormState>();

  String? validateName(String? value) => _validateServices.validateName(value);

  String? validateDueDate(String? value) =>
      _validateServices.validateDueDate(value);

  String? validatePrice(double? value) =>
      _validateServices.validatePrice(value);

  String? validateBarCode(String? value) =>
      _validateServices.validateBarCode(value);

  void onChange({
    String? name,
    DateTime? dueDate,
    double? price,
    String? barCode,
  }) {
    _setError(newState: false);
    _boleto = boleto.copyWith(
      name: name,
      dueDate: dueDate,
      price: price,
      barCode: barCode,
    );
    notifyListeners();
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
