import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_color.dart';

class DividerVerticalWidget extends StatelessWidget {
  const DividerVerticalWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 1,
      color: AppColors.stroke,
    );
  }
}