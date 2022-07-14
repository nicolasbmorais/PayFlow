import 'package:flutter/material.dart';
import 'package:payflow/shared/widget/bank_slip_list/bank_slip_list_controller.dart';
import 'package:payflow/shared/widget/bank_slip_tile/bank_slip_tile.dart';
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
