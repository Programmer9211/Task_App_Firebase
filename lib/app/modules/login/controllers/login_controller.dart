import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/services/auth_service.dart';
import 'package:task_app/app/routes/app_pages.dart';
import 'package:task_app/app/utility/indicator/indicator.dart';

class LoginController extends GetxController {
  AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var email = true.obs;
  var password = true.obs;

  // Function For validating Email input fields
  void validateEmail(String value) {
    email.value = value.isNotEmpty && _authService.isValidEmail(value);
  }

  // Function For validating Password Input Field
  void validatePassword(String value) {
    password.value = value.isNotEmpty;
  }

  // This function is called when clicked on login button
  void onLogin() async {
    if (email.value) {
      validateEmail(emailController.text);
    }

    if (password.value) {
      validatePassword(passwordController.text);
    }

    if (email.value && password.value) {
      Indicator.showIndicator();

      final result = await _authService.login(
          emailController.text, passwordController.text);

      Indicator.closeIndicator();

      if (result.status == 0) {
        // Indicator.showSnackBar(result.message);

        Get.offAllNamed(Routes.HOME);
      } else {
        Indicator.showSnackBar(result.message);
      }
    }
  }

  void onCreateNewAccount() async {
    Get.toNamed(Routes.SIGNUP);
  }
}
