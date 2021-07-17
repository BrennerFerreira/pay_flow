import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../shared/boleto/helpers/convert_bar_code_string.dart';
import 'status/bar_code_scanner_status.dart';

class BarCodeScannerController with ChangeNotifier {
  final _barCodeScanner = GoogleMlKit.vision.barcodeScanner();
  Timer? _timer;
  BarCodeScannerStatus _status = BarCodeScannerStatus();
  bool _isLoading = false;
  String _message =
      "Escolha como quer inserir o código de barras do seu boleto.";

  String get message => _message;

  void _setMessage(String newMessage) {
    _message = newMessage;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  void _setIsLoading({required bool newState}) {
    _isLoading = newState;
    notifyListeners();
  }

  void _setStatus({
    String? barCode,
    String? error,
  }) {
    _status = _status.copyWith(
      barCode: barCode,
      error: error,
    );
    notifyListeners();
  }

  BarCodeScannerStatus get status => _status;

  Future<String?> _scannerBarCode(InputImage inputImage) async {
    _timer = Timer(const Duration(seconds: 20), () {
      if (!status.hasBarCode) {
        _setMessage("O tempo para leitura do boleto foi excedido.");
      }
    });
    try {
      final barCodes = await _barCodeScanner.processImage(inputImage);

      String? barCode;

      for (final Barcode code in barCodes) {
        barCode = code.value.displayValue;
      }

      if (barCode != null && _status.barCode.isEmpty) {
        final formattedBarCode = ConvertBarCodeString.calculateRow(barCode);

        if (formattedBarCode.error != null) {
          _timer?.cancel();
          _setMessage(formattedBarCode.error!);
          _setIsLoading(newState: false);
          return null;
        }

        if (formattedBarCode.barCode != null) {
          _timer?.cancel();
          _setIsLoading(newState: true);
          _setMessage("Código de barras encontrado.");
          _barCodeScanner.close();
          _setIsLoading(newState: false);
          _setStatus(barCode: formattedBarCode.barCode);
          notifyListeners();
          return formattedBarCode.barCode;
        }
      }
    } catch (error) {
      _timer?.cancel();
      _setIsLoading(newState: false);
      _setMessage("Erro durante a leitura do código de barras.");
      return null;
    }
  }

  Future<String?> scanImage(File image) async {
    _setIsLoading(newState: true);
    _setMessage("Procurando por código de barras...");
    final inputImage = InputImage.fromFile(image);
    return _scannerBarCode(inputImage);
  }

  @override
  void dispose() {
    _barCodeScanner.close();

    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    super.dispose();
  }
}
