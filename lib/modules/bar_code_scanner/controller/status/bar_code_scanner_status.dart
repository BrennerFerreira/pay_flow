class BarCodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barCode;
  final bool shouldStopScanner;

  BarCodeScannerStatus({
    this.isCameraAvailable = false,
    this.shouldStopScanner = false,
    this.error = "",
    this.barCode = "",
  });

  bool get canShowCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarCode => barCode.isNotEmpty;

  BarCodeScannerStatus copyWith({
    bool? isCameraAvailable,
    String? error,
    String? barCode,
    bool? shouldStopScanner,
  }) {
    return BarCodeScannerStatus(
      isCameraAvailable: isCameraAvailable ?? this.isCameraAvailable,
      error: error ?? this.error,
      barCode: barCode ?? this.barCode,
      shouldStopScanner: shouldStopScanner ?? this.shouldStopScanner,
    );
  }

  @override
  String toString() {
    return 'BarCodeScannerStatus(isCameraAvailable: $isCameraAvailable, error: $error, barCode: $barCode, shouldStopScanner: $shouldStopScanner)';
  }
}
