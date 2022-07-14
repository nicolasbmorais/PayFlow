import 'package:flutter/material.dart';
import 'package:payflow/modules/extract_page/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/my_bank_slip/my_bank_slip.dart';
import 'package:payflow/shared/themes/app_color.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, HomeController homeController, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(157),
          child: Container(
            height: 157,
            color: AppColors.primary,
            child: Center(
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                      text: 'Olá, ',
                      style: TextStyles.titleRegular,
                      children: [
                        TextSpan(
                          text: 'Nícolas',
                          style: TextStyles.titleBoldBackground,
                        ),
                      ]),
                ),
                subtitle: Text(
                  'Mantenha suas contas em dia',
                  style: TextStyles.captionShape,
                ),
                trailing: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: pages[homeController.currentPage],
        bottomNavigationBar: SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: homeController.currentPage == 0
                        ? AppColors.primary
                        : AppColors.body,
                  ),
                  onPressed: () {
                    homeController.setpage(0);
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/insert_boleto'),

                  // Navigator.pushNamed(context, '/barcode'),
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.add_box_outlined,
                      color: AppColors.background,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.description_outlined,
                    color: homeController.currentPage == 1
                        ? AppColors.primary
                        : AppColors.body,
                  ),
                  onPressed: () {
                    homeController.setpage(1);
                  },
                ),
              ],
            )),
      );
    });
  }

  final pages = [
    const MyBankSlipPage(),
    const ExtractPage(),
  ];
}
