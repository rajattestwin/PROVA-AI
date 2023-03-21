import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static getToast(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white,
      borderRadius: 10,
      duration: const Duration(seconds: 7),
      shouldIconPulse: false,
      icon: const Icon(
        Icons.close,
        color: Colors.black,
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      colorText: color,
      dismissDirection: DismissDirection.startToEnd,
      snackPosition: SnackPosition.TOP,
    );
  }
}
