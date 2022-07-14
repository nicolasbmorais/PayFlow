import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_style.dart';

class BankSlipInfoWidget extends StatelessWidget {
  const BankSlipInfoWidget({Key? key, required this.size}) : super(key: key);
  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppImages.logomini,
              color: AppColors.background,
              width: 56,
              height: 34,
            ),
            Container(
              height: 32,
              width: 1,
              color: AppColors.background,
            ),
            Text.rich(
              TextSpan(
                text: "Você tem ",
                style: TextStyles.captionBackground,
                children: [
                  TextSpan(
                    text: "$size boletos\n",
                    style: TextStyles.captionBoldBackground,
                  ),
                  TextSpan(
                    text: "cadastrados para pagar",
                    style: TextStyles.captionBackground,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
