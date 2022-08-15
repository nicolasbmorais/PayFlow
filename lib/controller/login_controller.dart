import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/model/user.dart';
import 'package:payflow/controller/auth_controller.dart';

class LoginController with ChangeNotifier {
  final authController = AuthController();

  void signIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user =
          UserModel(name: response!.displayName!, photoURL: response.photoUrl);
      authController.setUser(context, user);
      notifyListeners();
    } catch (error) {
      authController.setUser(context, null);
      notifyListeners();
      //TODO: adicionar widget para exibir mensagem de erro no login
    }
    notifyListeners();
  }
}
