import 'package:flutter/cupertino.dart';

class HomeController with ChangeNotifier {
  int currentPage = 0;

  void setpage(int index) {
    currentPage = index;
    notifyListeners();
  }
}
