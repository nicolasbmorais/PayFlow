import 'package:flutter/material.dart';
import 'package:payflow/shared/models/bank_slip.dart';
import 'package:payflow/shared/themes/app_text_style.dart';

class BankSlipTileWidget extends StatelessWidget {
  final BankSlipModel data;
  const BankSlipTileWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        data.name!,
        style: TextStyles.titleListTile,
      ),
      subtitle: Text(
        "Vence em ${data.dueDate}",
        style: TextStyles.captionBody,
      ),
      trailing: Text.rich(
        TextSpan(
          text: "R\$ ",
          style: TextStyles.trailingRegular,
          children: [
            TextSpan(
              text: data.value!.toStringAsFixed(2),
              style: TextStyles.trailingBold,
            )
          ],
        ),
      ),
    );
  }
}
