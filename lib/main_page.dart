import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insert_bank_slip/insert_bank_slip.dart';
import 'package:payflow/modules/insert_bank_slip/insert_bank_slip_controller.dart';
import 'package:payflow/modules/login/pages/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/widget/bank_slip_list/bank_slip_list_controller.dart';
import 'package:provider/provider.dart';
import 'modules/login/controller/login_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider<AuthController>(
            create: (context) => AuthController()),
        ChangeNotifierProvider<HomeController>(
            create: (context) => HomeController()),
        ChangeNotifierProvider<BarcodeScannerController>(
            create: (context) => BarcodeScannerController()),
        ChangeNotifierProvider<InsertBankSlipController>(
            create: (context) => InsertBankSlipController()),
        ChangeNotifierProvider<BankListController>(
            create: (context) => BankListController()),
      ],
      child: MaterialApp(
        title: 'Pay Flow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: AppColors.primary,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/barcode': (context) => const BarcodeScannerPage(),
          '/insert_boleto': (context) => InsertBankSlipPage(
              barcode: ModalRoute.of(context) != null
                  ? ModalRoute.of(context)!.settings.arguments.toString()
                  : null),
          '/home': (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel),
        },
      ),
    );
  }
}
