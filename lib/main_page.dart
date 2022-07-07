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
import 'package:payflow/shared/themes/app_color.dart';
import 'package:provider/provider.dart';
import 'modules/login/controller/login_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  MainPage() {
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
            create: (context) => LoginController(),),
        ChangeNotifierProvider<AuthController>(
            create: (context) => AuthController()),
        ChangeNotifierProvider<HomeController>(
            create: (context) => HomeController()),
        ChangeNotifierProvider<BarcodeScannerController>(
            create: (context) => BarcodeScannerController()),
                    ChangeNotifierProvider<InsertBankSlipController>(
            create: (context) => InsertBankSlipController()),
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
          '/splash': (context) => SplashScreen(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/barcode': (context) => BarcodeScannerPage(),
          '/insert_boleto': (context) => InsertBankSlipPage()
        },
      ),
    );
  }
}
