import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../shared/boleto/helpers/convert_bar_code_string.dart';
import 'status/bar_code_scanner_status.dart';

class BarCodeScannerController with ChangeNotifier {
  final _barCodeScanner = GoogleMlKit.vision.barcodeScanner();
  BarCodeScannerStatus _status = BarCodeScannerStatus();
  CameraController? _cameraController;
  bool _isLoading = true;

  late Timer _timer;

  bool get isLoading => _isLoading;

  void _setIsLoading({required bool newState}) {
    _isLoading = newState;
    notifyListeners();
  }

  void _setStatus({
    String? barCode,
    String? error,
    bool? isCameraAvailable,
    bool? shouldStopScanner,
  }) {
    _status = _status.copyWith(
      barCode: barCode,
      error: error,
      isCameraAvailable: isCameraAvailable,
      shouldStopScanner: shouldStopScanner,
    );
    notifyListeners();
  }

  CameraController? get cameraController => _cameraController;
  BarCodeScannerStatus get status => _status;

  void stopImageStream() {
    _setStatus(shouldStopScanner: true);

    if (_cameraController != null &&
        _cameraController!.value.isStreamingImages) {
      _cameraController!.stopImageStream();
    }

    if (_timer.isActive) {
      _timer.cancel();
    }

    notifyListeners();
  }

  Future<void> startScan() async {
    _setIsLoading(newState: true);
    _setStatus(error: "");
    try {
      final response = await availableCameras();

      if (response.isEmpty) {
        _setStatus(error: "No cameras available");
        notifyListeners();
      }

      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );

      _cameraController ??= CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      if (!_cameraController!.value.isInitialized) {
        await _cameraController!.initialize();
      }
      _setStatus(isCameraAvailable: true);
      _setIsLoading(newState: false);
      _scanWithCamera();
      _listenCamera();
    } catch (error) {
      _setStatus(error: error.toString());
      stopImageStream();
    }
  }

  void _scanWithCamera() {
    _timer = Timer(const Duration(seconds: 20), () {
      if (!status.hasBarCode) {
        _setStatus(error: "Timeout de leitura do boleto");
        stopImageStream();
      }
    });
  }

  void _listenCamera() {
    if (_cameraController!.value.isStreamingImages == false) {
      _cameraController!.startImageStream(
        (image) async {
          if (!status.shouldStopScanner) {
            try {
              final WriteBuffer allBytes = WriteBuffer();

              for (final Plane plane in image.planes) {
                allBytes.putUint8List(plane.bytes);
              }

              final bytes = allBytes.done().buffer.asUint8List();

              final Size imageSize = Size(
                image.height.toDouble(),
                image.width.toDouble(),
              );

              const InputImageRotation imageRotation =
                  InputImageRotation.Rotation_0deg;

              final InputImageFormat imageFormat =
                  InputImageFormatMethods.fromRawValue(
                          image.format.raw as int) ??
                      InputImageFormat.NV21;

              final planeData = image.planes.map((plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              }).toList();

              final inputImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation,
                inputImageFormat: imageFormat,
                planeData: planeData,
              );

              final inputImageCamera = InputImage.fromBytes(
                bytes: bytes,
                inputImageData: inputImageData,
              );

              _scannerBarCode(inputImageCamera);
            } catch (_) {
              _setStatus(error: "Failed to find a bar code");
              stopImageStream();
            }
          }
        },
      );
    }
  }

  Future<void> _scannerBarCode(InputImage inputImage) async {
    try {
      final barCodes = await _barCodeScanner.processImage(inputImage);

      String? barCode;

      for (final Barcode code in barCodes) {
        barCode = code.value.displayValue;
      }

      if (barCode != null && _status.barCode.isEmpty) {
        _setIsLoading(newState: true);
        final String? formattedBarCode =
            ConvertBarCodeString.calculateRow(barCode);

        if (formattedBarCode == null) {
          _setStatus(error: "Could not convert bar code");
          return;
        }

        _setStatus(barCode: formattedBarCode);
        stopImageStream();
        _barCodeScanner.close();
        _cameraController?.dispose();
        notifyListeners();
      }

      return;
    } catch (error) {
      _setStatus(
        error: "Error while trying to read the bar code",
      );
      notifyListeners();
    }
  }

  Future<void> scanGalleryImage(File image) async {
    stopImageStream();
    _setIsLoading(newState: true);
    final inputImage = InputImage.fromFile(image);
    _scannerBarCode(inputImage);
  }

  @override
  void dispose() {
    stopImageStream();
    _barCodeScanner.close();
    _cameraController?.dispose();
    super.dispose();
  }
}
