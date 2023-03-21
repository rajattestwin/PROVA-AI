// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provaai/screens/Login/sign_up.dart';
import 'package:provaai/screens/Play/dashboard.dart';

import 'controllers/User/userController.dart';

class Root extends GetWidget<UserController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.verifying.value ? DashBoardScreen() : SignUp(),
    );
  }
}
