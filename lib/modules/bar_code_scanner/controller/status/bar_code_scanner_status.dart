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

  factory BarCodeScannerStatus.availableCamera() =>
      BarCodeScannerStatus(isCameraAvailable: true);

  factory BarCodeScannerStatus.error(String error) =>
      BarCodeScannerStatus(error: error, shouldStopScanner: true);

  factory BarCodeScannerStatus.barCode(String barCode) =>
      BarCodeScannerStatus(barCode: barCode, shouldStopScanner: true);

  bool get canShowCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarCode => barCode.isNotEmpty;
}
