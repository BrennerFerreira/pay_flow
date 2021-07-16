class BarCodeScannerStatus {
  final String error;
  final String barCode;

  BarCodeScannerStatus({
    this.error = "",
    this.barCode = "",
  });

  bool get hasError => error.isNotEmpty;

  bool get hasBarCode => barCode.isNotEmpty;

  BarCodeScannerStatus copyWith({
    String? error,
    String? barCode,
    bool? shouldStopScanner,
  }) {
    return BarCodeScannerStatus(
      error: error ?? this.error,
      barCode: barCode ?? this.barCode,
    );
  }

  @override
  String toString() {
    return 'BarCodeScannerStatus(error: $error, barCode: $barCode)';
  }
}
