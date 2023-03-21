// ignore_for_file: prefer_final_fields, file_names, non_constant_identifier_names, unnecessary_this, unrelated_type_equality_checks, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/models/RegisterStudent.dart';
import 'package:provaai/utils/apiEndpoints.dart';
import 'package:provaai/utils/customToast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var state = ''.obs;
  var course = ''.obs;
  var avatar = 0.obs;

  var wallet_balance = 0.obs;
  var added_amt = 0.obs;
  var reward_amt = 0.obs;
  var bonus_wallet_balance = 0.obs;

  var phoneController = TextEditingController();
  var verificationId = ''.obs;
  ApiEndpoints apiEndpoints = ApiEndpoints();

  @override
  void onInit() {
    super.onInit();
  }

  void registerStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    RegisterStudent stud = RegisterStudent(
      name: name.value,
      deviceToken: '',
      email: email.value,
      phone: Get.find<UserController>().phone.value,
      state: state.value,
      course: course.value,
      avatarIdx: avatar.value.toString(),
    );
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
      );
      var result = await http.post(
        Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.registerStudent,
        ),
        body: stud.toJson(),
      );
      if (result.statusCode == 200) {
        var resbody = jsonDecode(result.body);
        if (resbody['status'] == 'Success') {
          prefs.setString('loggedStatus', 'loggedIn');
          Get.find<UserController>().loggedStatus.value = 'loggedIn';
          DeopsitSignUpBonus();
          Get.find<UserController>().getWalletBalance();
          //Get.offAll(const SplashScreen());
        } else {
          CustomToast.getToast("Failed", resbody['message'], Colors.red);
        }
      } else {
        Get.back();
        CustomToast.getToast("Failed", "Try AgAin", Colors.red);
      }
    } on Exception catch (e) {
      Get.back();
      CustomToast.getToast("Failed", "Try AgAin", Colors.red);
    }
  }

  void DeopsitSignUpBonus() async {
    var res = await http.post(
      Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.deopsitSignUpBonus),
      headers: {
        'Phone-Number': Get.find<UserController>().phone.value,
      },
    );
    if (res.statusCode == 200) {
      var resbody = jsonDecode(res.body);
      if (resbody['status'] == 'Success') {
        CustomToast.getToast(
            "Congratulations", resbody['message'], Colors.purple);
      }
    }
  }
}
