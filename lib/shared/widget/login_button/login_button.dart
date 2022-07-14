import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_style.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border:
              const Border.fromBorderSide(BorderSide(color: AppColors.stroke)),
        ),
        height: 56,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.google),
                    const SizedBox(width: 16),
                    Container(
                      color: AppColors.stroke,
                      width: 1,
                      height: 56,
                    )
                  ],
                )),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Entrar com Google',
                    style: TextStyles.buttonGray,
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
