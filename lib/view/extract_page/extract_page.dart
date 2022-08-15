import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:payflow/controller/bank_slip_list_controller.dart';
import 'package:payflow/view/insert_bank_slip/bank_slip_list/bank_slip_list.dart';

class ExtractPage extends StatelessWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, BankListController bankListController, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Text(
                        "Meus extratos",
                        style: TextStyles.titleBoldHeading,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: AppColors.stroke,
                  ),
                ),
                const BankSlipListWidget()
              ],
            ),
          ),
        ],
      );
    });
  }
}
