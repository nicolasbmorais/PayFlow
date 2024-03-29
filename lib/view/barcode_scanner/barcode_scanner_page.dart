import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:payflow/controller/barcode_scanner_controller.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  void initState() {
    Future.microtask(() async {
      final barcodeController = context.read<BarcodeScannerController>();
      barcodeController.getAvailableCameras();
      barcodeController.addListener(() {
        if (barcodeController.statusNotifier.hasBarcode) {
          Navigator.pushReplacementNamed(context, '/insert_boleto',
              arguments: barcodeController.statusNotifier.barcode);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    context.read<BarcodeScannerController>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,
          BarcodeScannerController barcodeScannerController, child) {
        return SafeArea(
          child: Stack(
            children: [
              barcodeScannerController.statusNotifier.showCamera
                  ? Container(
                      child: barcodeScannerController.cameraController!
                          .buildPreview(),
                    )
                  : Container(),
              RotatedBox(
                quarterTurns: 1,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    title: Text(
                      "Escaneie o código de barras do boleto",
                      style: TextStyles.buttonBackground,
                    ),
                    centerTitle: true,
                    leading: const BackButton(
                      color: AppColors.background,
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                          child: Container(
                        color: Colors.black.withOpacity(0.6),
                      )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.transparent,
                          )),
                      Expanded(
                          child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ))
                    ],
                  ),
                  bottomNavigationBar: SetLabelButtons(
                      primaryLabel: "Inserir código do boleto",
                      primaryOnPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "/insert_boleto");
                      },
                      secondaryLabel: "Adicionar da galeria",
                      secondaryOnPressed: () {}),
                ),
              ),
              barcodeScannerController.statusNotifier.hasError
                  ? BottomSheetWidget(
                      title:
                          "Não foi possível identificar um código de barras.",
                      subtitle:
                          "Tente escanear novamente ou digite o código do seu boleto.",
                      primaryLabel: "Escanear novamente",
                      primaryOnPressed: () {
                        barcodeScannerController.scanWithCamera();
                      },
                      secondaryLabel: "Digitar código",
                      secondaryOnPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "/insert_boleto");
                      },
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
