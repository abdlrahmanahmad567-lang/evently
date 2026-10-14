import 'package:evently/cor/routes/app_route_name.dart';
import 'package:evently/cor/services/toast.dart';
import 'package:evently/main.dart';
import 'package:evently/modules/auth/services/fairbase_servies.dart';
import 'package:flutter/material.dart';

class AuthProvieder extends ChangeNotifier {
  FairbaseServies servies = FairbaseServies();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoding = false;

  Future<void> creatAccount() async {
    isLoding = true;
    notifyListeners();
    try {
      var user = await servies.createAccount(
        name: nameController.text.trim(),
        password: passwordController.text,
        email: emailController.text.trim(),
      );
      if (user != null) {
        await user.user?.sendEmailVerification();
        Toast.show(title: "Account created! Please check your email to verify.");
        Navigator.pushReplacementNamed(
          navigatorKey.currentContext!,
          AppRouteName.loginScreen,
        );
      }
    } catch (e) {
      Toast.show(title: e.toString(), typ: ToastTyp.error);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }

  Future<void> login() async {
    isLoding = true;
    notifyListeners();
    try {
      var user = await servies.login(
        password: passwordController.text,
        email: emailController.text.trim(),
      );
      if (user != null && user.user != null) {
        Toast.show(title: "Welcome ${user.user?.displayName ?? ''}");
        navigatorKey.currentState?.pushReplacementNamed(
          AppRouteName.layoutScrreen,
        );
      }
    } catch (e) {
      Toast.show(title: e.toString(), typ: ToastTyp.error);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    isLoding = true;
    notifyListeners();
    try {
      var userCredential = await servies.signInWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        Toast.show(title: "Welcome ${userCredential.user?.displayName ?? ''}");
        navigatorKey.currentState?.pushReplacementNamed(
          AppRouteName.layoutScrreen,
        );
      }
    } catch (e) {
      Toast.show(title: e.toString(), typ: ToastTyp.error);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword() async {
    isLoding = true;
    notifyListeners();
    try {
      await servies.resetPassword(emailController.text.trim());
      Toast.show(title: "Password reset link sent to your email");
    } catch (e) {
      Toast.show(title: e.toString(), typ: ToastTyp.error);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }
}
