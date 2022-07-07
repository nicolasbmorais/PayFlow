import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController with ChangeNotifier {
  var _statusNotifier = BarcodeScannerStatus();

  BarcodeScannerStatus get status => _statusNotifier;

  set status(BarcodeScannerStatus status) => _statusNotifier = status;

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  InputImage? imagePicker;

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
      status = BarcodeScannerStatus.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
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

  void scanWithImagePicker() async {
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
    notifyListeners();
  }

  void scanWithCamera() {
    status = BarcodeScannerStatus.available();
    Future.delayed(Duration(seconds: 25)).then((value) {
      if (status.hasBarcode == false)
        status = BarcodeScannerStatus.error("Tempo esgotado na leitura do boleto");
    });
    print(status);
    notifyListeners();
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            final InputImageRotation imageRotation =
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
    notifyListeners();
  }
}
