import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Indicator {
  static void showIndicator() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void closeIndicator() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static void showSnackBar(String text, {Color colors = Colors.black87}) {
    Get.showSnackbar(GetSnackBar(
      message: text,
      backgroundColor: colors,
      duration: const Duration(seconds: 3),
    ));
  }
}
