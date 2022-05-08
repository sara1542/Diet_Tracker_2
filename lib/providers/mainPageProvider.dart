import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mainProvider extends ChangeNotifier {
  bool isLogin = true;
  void toggleisLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  bool showPassword = false;
  void togglePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  bool showConfirmPassword = false;
  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  bool showloginPassword = false;
  void toggleLoginPassword() {
    showloginPassword = !showloginPassword;
    notifyListeners();
  }
}
