import 'package:flutter/material.dart';
import 'package:payflow/shared/models/bank_slip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBankSlipController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  BankSlipModel bankSlipModel = BankSlipModel();

  String? validateName(String? value) =>
      value!.isEmpty ? 'O nome não pode ser vazio' : null;

  String? validateDate(String? value) => value!.isEmpty
      ? 'A data de vencimento não pode ser vazia'
      : null; //TODO: Depois alterar para validação de datas válidas e todos os outros dados

  String? validateValue(double? value) =>
      value == 0 ? 'Insira um valor maior que "R\$ 0,00' : null;

  String? validateBarcode(String? value) =>
      value!.isEmpty ? 'O código do boleto não pode ser vazio' : null;

  void onChange({
    String? name,
    String? dueDate,
    String? barcode,
    double? value,
  }) {
    bankSlipModel = bankSlipModel.copyWith(
      name: name,
      dueDate: dueDate,
      barcode: barcode,
      value: value,
    );
  }

  Future<void> saveBankSlip() async {
    final instance = await SharedPreferences.getInstance();
    final bankSlip = instance.getStringList('bankSlip') ?? <String>[];
    bankSlip.add(bankSlipModel.toJson());
    await instance.setStringList('bankSlip', bankSlip);
    notifyListeners();
    return;
  }

  Future<void> registerBankSlip(BuildContext context) async {
    final form = formKey.currentState;
    if (form!.validate()) {
      await saveBankSlip();
      Navigator.pop(context);
    }
    notifyListeners();
  }
}
