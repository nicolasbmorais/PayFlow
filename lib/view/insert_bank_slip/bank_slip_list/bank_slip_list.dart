import 'package:flutter/material.dart';
import 'package:payflow/controller/bank_slip_list_controller.dart';
import 'package:payflow/view/insert_bank_slip/bank_slip_tile/bank_slip_tile.dart';
import 'package:provider/provider.dart';

class BankSlipListWidget extends StatefulWidget {
  const BankSlipListWidget({Key? key}) : super(key: key);

  @override
  State<BankSlipListWidget> createState() => _BankSlipListWidgetState();
}

class _BankSlipListWidgetState extends State<BankSlipListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, BankListController bankListController, child) {
      return Column(
        children: bankListController.bankSlip
            .map((e) => BankSlipTileWidget(data: e))
            .toList(),
      );
    });
  }
}
