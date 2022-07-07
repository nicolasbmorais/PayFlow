import 'package:flutter/material.dart';
import 'package:payflow/shared/models/bank_slip.dart';

class InsertBankSlipController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  BankSlipModel bankSlipModel = BankSlipModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? 'O nome não pode ser vazio' : null;
  String? validateDate(String? value) => value?.isEmpty ?? true
      ? 'A data de vencimento não pode ser vazia'
      : null; //TODO: Depois alterar para validação de datas válidas e todos os outros dados
  String? validateValue(double? value) =>
      value == 0 ? 'Insira um valor maior que "R\$ 0,00' : null;
  String? validateBarcode(String? value) =>
      value?.isEmpty ?? true ? 'O código do boleto não pode ser vazio' : null;
  //TODO: Testar e ver se preciso por notify e fazer get

  void onChange({
    String? name,
    dueDate,
    barcode,
    double? value,
  }) {
    bankSlipModel = bankSlipModel.copyWith(
      name: name,
      dueDate: dueDate,
      barcode: barcode,
      value: value,
    );
  }

  void saveBankSlip() {}

  void registerBankSlip() {
    final form = formKey.currentState;
    if (form!.validate()) {
      print(bankSlipModel);
      notifyListeners();
    }
    notifyListeners();
  }
}
