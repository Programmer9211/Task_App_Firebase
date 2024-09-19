import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/services/auth_service.dart';
import 'package:task_app/app/routes/app_pages.dart';
import 'package:task_app/app/utility/indicator/indicator.dart';

class SignupController extends GetxController {
  AuthService _authService = AuthService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var email = true.obs;
  var password = true.obs;
  var name = true.obs;

  // Function For validating Email input fields
  void validateEmail(String value) {
    email.value = value.isNotEmpty && _authService.isValidEmail(value);
  }

  // Function For validating Password Input Field
  void validatePassword(String value) {
    password.value = value.isNotEmpty;
  }

  // Function For validating Name Input Field
  void validateName(String value) {
    name.value = value.isNotEmpty;
  }

  // This Function is called when clicked on Signup Button.
  void onSignup() async {
    if (name.value) {
      validateName(nameController.text);
    }
    if (email.value) {
      validateEmail(emailController.text);
    }
    if (password.value) {
      validatePassword(passwordController.text);
    }

    if (name.value && email.value && password.value) {
      Indicator.showIndicator();

      final result = await _authService.signup(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      Indicator.closeIndicator();

      if (result.status == 0) {
        // Indicator.showSnackBar(result.message);

        Get.offAllNamed(Routes.HOME);
      } else {
        Indicator.showSnackBar(result.message);
      }
    }
  }
}
