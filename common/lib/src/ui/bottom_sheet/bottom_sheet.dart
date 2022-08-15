import 'package:common/common.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final String primaryLabel;
  final String secondaryLabel;
  final String title;
  final String subtitle;
  final VoidCallback primaryOnPressed;
  final VoidCallback secondaryOnPressed;
  const BottomSheetWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.shape,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text.rich(
                        TextSpan(
                          text: title,
                          style: TextStyles.buttonBoldHeading,
                          children: [
                            TextSpan(
                              text: '\n$subtitle',
                              style: TextStyles.buttonHeading,
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 1,
                      color: AppColors.stroke,
                    ),
                    SetLabelButtons(
                      enablePrimaryColor: true,
                      primaryLabel: primaryLabel,
                      secondaryLabel: secondaryLabel,
                      primaryOnPressed: primaryOnPressed,
                      secondaryOnPressed: secondaryOnPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
