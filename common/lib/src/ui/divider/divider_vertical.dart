import 'package:common/common.dart';
import 'package:flutter/material.dart';

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