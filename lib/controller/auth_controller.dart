import 'package:flutter/material.dart';
import 'package:payflow/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  void setUser(BuildContext context, var user) {
    if (user != null) {
      saveUser(user);
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
      notifyListeners();
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get('user') as String;
      setUser(context, UserModel.fromJson(json));
      return;
    } else {
      setUser(context, null);
    }
  }
}
