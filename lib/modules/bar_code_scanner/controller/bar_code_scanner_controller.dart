import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'status/bar_code_scanner_status.dart';

class BarCodeScannerController {
  final barCodeScanner = GoogleMlKit.vision.barcodeScanner();
  CameraController? _cameraController;

  final _statusNotifier =
      ValueNotifier<BarCodeScannerStatus>(BarCodeScannerStatus());

  ValueNotifier<BarCodeScannerStatus> get statusNotifier => _statusNotifier;
  CameraController? get cameraController => _cameraController;
  BarCodeScannerStatus get status => _statusNotifier.value;
  set status(BarCodeScannerStatus status) => _statusNotifier.value = status;

  Future<void> getAvailableCameras() async {
    try {
      final response = await availableCameras();

      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );

      _cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      status = BarCodeScannerStatus.availableCamera();
      scanWithCamera();
      _listenCamera();
    } catch (error) {
      status = BarCodeScannerStatus.error(error.toString());
    }
  }

  void scanWithCamera() {
    status = BarCodeScannerStatus.availableCamera();
    Future.delayed(const Duration(seconds: 20)).then(
      (value) {
        if (!status.hasBarCode) {
          status = BarCodeScannerStatus.error("Timeout de leitura do boleto");
        }
      },
    );
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
            } catch (error) {
              print(error);
            }
          }
        },
      );
    }
  }

  Future<void> _scannerBarCode(InputImage inputImage) async {
    try {
      final barCodes = await barCodeScanner.processImage(inputImage);

      String? barCode;

      for (final Barcode code in barCodes) {
        barCode = code.value.displayValue;
      }

      if (barCode != null && status.barCode.isEmpty) {
        status = BarCodeScannerStatus.barCode(barCode);
        _cameraController!.dispose();
        await barCodeScanner.close();
      }

      return;
    } catch (error) {
      print("Erro na leitura: $error");
    }
  }

  Future<void> scanGalleryImage() async {
    final response = await ImagePicker().getImage(source: ImageSource.gallery);

    if (response != null) {
      final inputImage = InputImage.fromFilePath(response.path);
      _scannerBarCode(inputImage);
    } else {
      status = BarCodeScannerStatus.error("No picture selected");
    }

    return;
  }

  void dispose() {
    statusNotifier.dispose();
    barCodeScanner.close();

    if (status.canShowCamera) {
      _cameraController!.dispose();
    }
  }
}
