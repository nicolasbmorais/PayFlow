import 'package:flutter/material.dart';
import 'package:payflow/modules/login/controller/login_controller.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widget/login_button/login_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<LoginController>(
        builder: (BuildContext context, LoginController loginController, child) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: size.height * 0.36,
                width: size.width,
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 25,
                child: Image.asset(
                  AppImages.person,
                  width: 202,
                  height: 300,
                ),
              ),
              Positioned(
                bottom: size.height * 0.05,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Image.asset(AppImages.logomini),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 70, right: 70, top: 10),
                      child: Text(
                        "Organize seus boletos em um só lugar",
                        style: TextStyles.titleHome,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 25),
                      child: LoginButton(
                        onTap: () async {
                          loginController.signIn(context);
                         
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
