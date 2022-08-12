import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController with ChangeNotifier {
  BarcodeScannerStatus statusNotifier = BarcodeScannerStatus();

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  CameraController? cameraController;

  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);
      cameraController =
          CameraController(camera, ResolutionPreset.max, enableAudio: false);
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();

      notifyListeners();
    } catch (e) {
      statusNotifier = BarcodeScannerStatus.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      String? barcode;
      for (Barcode item in barcodes) {
        barcode = item.displayValue;
      }

      if (barcode != null && statusNotifier.barcode.isEmpty) {
        statusNotifier = BarcodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.close();
      }
      notifyListeners();
      return;
    } catch (e) {
      print("*** ERRO DA LEITURA $e");
    }
    notifyListeners();
  }

  void scanWithCamera() {
    statusNotifier = BarcodeScannerStatus.available();
    Future.delayed(const Duration(seconds: 25)).then((value) {
      if (statusNotifier.hasBarcode == false) {
        statusNotifier =
            BarcodeScannerStatus.error("Tempo esgotado na leitura do boleto");
      }
    });
    print(statusNotifier);
    notifyListeners();
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false) {
      cameraController!.startImageStream((cameraImage) async {
        if (statusNotifier.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            const InputImageRotation imageRotation =
                InputImageRotation.rotation0deg;
            final InputImageFormat inputImageFormat =
                InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.nv21;
            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );
            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, inputImageData: inputImageData);

            scannerBarCode(inputImageCamera);
            notifyListeners();
          } catch (e) {
            print(e);
          }
        }
      });
    }
    notifyListeners();
  }
}
