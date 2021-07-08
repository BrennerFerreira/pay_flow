import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/boleto/models/boleto.dart';
import '../services/validate_services.dart';

class InsertBoletoController {
  final _validateServices = ValidateServices();
  Boleto boleto = Boleto();
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
    String? dueDate,
    double? price,
    String? barCode,
  }) {
    boleto = boleto.copyWith(
      name: name,
      dueDate: dueDate,
      price: price,
      barCode: barCode,
    );
  }

  Future<void> _saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList("boletos") ?? <String>[];
      boletos.add(boleto.toJson());
      await instance.setStringList("boletos", boletos);
      return;
    } catch (error) {
      print(error);
    }
  }

  Future<void> submitBoleto() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      return _saveBoleto();
    }
  }
}
