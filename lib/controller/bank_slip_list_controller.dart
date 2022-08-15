import 'package:flutter/cupertino.dart';
import 'package:payflow/model/bank_slip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankListController with ChangeNotifier {
  List<BankSlipModel> bankSlip = <BankSlipModel>[];

  BankListController() {
    getBankSlip();
  }

  Future<void> getBankSlip() async {
   try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('bankSlip') ?? <String>[];
      bankSlip = response.map((e) => BankSlipModel.fromJson(e)).toList();
   } catch (e) {
    bankSlip = <BankSlipModel>[];
   }
  }
}
