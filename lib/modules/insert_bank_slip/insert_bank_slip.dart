import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_bank_slip/insert_bank_slip_controller.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widget/input_text/input_text_widgets.dart';
import 'package:payflow/shared/widget/set_label_buttons/set_label_button.dart';
import 'package:provider/provider.dart';

class InsertBankSlipPage extends StatefulWidget {
  const InsertBankSlipPage({Key? key, this.barcode}) : super(key: key);

  final String? barcode;
  @override
  State<InsertBankSlipPage> createState() => _InsertBankSlipPageState();
}

class _InsertBankSlipPageState extends State<InsertBankSlipPage> {
  final barcodeTextController = TextEditingController();
  final dueDateTextController = MaskedTextController(mask: '00/00/0000');
  final moneyTextController =
      MoneyMaskedTextController(leftSymbol: 'R\$', decimalSeparator: ',');

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,
        InsertBankSlipController insertBankSlipController, child) {
      return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: const BackButton(color: AppColors.input),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 0,
                    ), // TODO: Olhar depois no emulador
                    child: Text(
                      'Preencha os dados do boleto',
                      style: TextStyles.titleBoldHeading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Form(
                      key: insertBankSlipController.formKey,
                      child: Column(
                        children: [
                          InputTextWidget(
                            keyboardType: TextInputType.name,
                            validator: insertBankSlipController.validateName,
                            icon: FontAwesomeIcons.fileLines,
                            label: 'Nome do boleto',
                            onChanged: (value) {
                              insertBankSlipController.onChange(name: value);
                            },
                          ),
                          InputTextWidget(
                            keyboardType: TextInputType.datetime,
                            validator: insertBankSlipController.validateDate,
                            controller: dueDateTextController,
                            icon: FontAwesomeIcons.circleXmark,
                            label: 'Vencimento',
                            onChanged: (value) {
                              insertBankSlipController.onChange(dueDate: value);
                            },
                          ),
                          InputTextWidget(
                            keyboardType: TextInputType.number,
                            controller: moneyTextController,
                            label: 'Valor',
                            icon: FontAwesomeIcons.wallet,
                            validator: (_) => insertBankSlipController
                                .validateValue(moneyTextController.numberValue),
                            onChanged: (value) {
                              insertBankSlipController.onChange(
                                  value: moneyTextController.numberValue);
                            },
                          ),
                          InputTextWidget(
                            keyboardType: TextInputType.number,
                            validator: insertBankSlipController.validateBarcode,
                            controller: barcodeTextController,
                            icon: FontAwesomeIcons.barcode,
                            label: 'Código',
                            onChanged: (value) {
                              insertBankSlipController.onChange(barcode: value);
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          bottomNavigationBar: SetLabelButtons(
            primaryLabel: 'Cancelar',
            secondaryLabel: 'Cadastrar',
            enableSecondaryColor: true,
            primaryOnPressed: () async {
              Navigator.pop(context);
            },
            secondaryOnPressed: () async {
              await insertBankSlipController.registerBankSlip(context);
            },
          ));
    });
  }
}
