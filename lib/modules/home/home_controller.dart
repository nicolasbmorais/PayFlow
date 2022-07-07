import 'package:flutter/cupertino.dart';

class HomeController with ChangeNotifier {
  var currentPage = 0;
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  // bool _changeIcon;
  // bool get changeIcon => _changeIcon;  TODO: inicia ele como falso, depois faz a função, deve trocar a cor

  // void setChangeIcon(value) {
  //   _changeIcon = value;
  //   setStatus(Status.success);
  // }

  void setpage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void setSelected() {
    _isSelected = !_isSelected;
    notifyListeners();
  }
}
