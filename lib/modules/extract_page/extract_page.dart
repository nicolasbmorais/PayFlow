import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widget/bank_slip_info/bank_slip_info.dart';
import 'package:payflow/shared/widget/bank_slip_list/bank_slip_list.dart';
import 'package:payflow/shared/widget/bank_slip_list/bank_slip_list_controller.dart';
import 'package:provider/provider.dart';

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
