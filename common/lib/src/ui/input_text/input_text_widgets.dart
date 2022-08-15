import 'package:common/common.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanged,
    required this.keyboardType,
    this.initialValue,
    this.validator,
    this.controller,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextFormField(
              keyboardType: keyboardType,
              validator: validator,
              initialValue: initialValue,
              onChanged: onChanged,
              controller: controller,
              style: TextStyles.input,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  labelText: label,
                  labelStyle: TextStyles.input,
                  border: InputBorder.none,
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Icon(
                          icon,
                          color: AppColors.primary,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 48,
                        color: AppColors.stroke,
                      )
                    ],
                  ))),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          )
        ],
      ),
    );
  }
}
