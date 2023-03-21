// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/models/DuosTest/duosChallenge.dart';
import 'package:provaai/utils/customToast.dart';

import '../../screens/Play/PlayTest.dart';
import '../../utils/apiEndpoints.dart';

class DuosJoinController extends GetxController {
  joinDuos(DuosChallenge dc) async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      var res = await http.patch(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.duosJoin),
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
        },
        body: {
          'challenge_id': dc.challengeId.toString(),
        },
      );
      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);
        log(json.toString());
        if (json['status'] == 'Success') {
          CustomToast.getToast(
              json['status'],
              "\u{20B9}${json['wallet_amt_deducted']} from wallet and \u{20B9}${json['bonus_amt_deducted']} from bonus",
              Colors.green);
          Get.find<UserController>().getWalletBalance();
          Get.off(PlayTestScreen(dc: dc, gc: null));
        } else {
          Get.back();
          CustomToast.getToast(json['status'], json['message'], Colors.red);
        }
      } else {
        Get.back();
        CustomToast.getToast("Failed!", "Try Again", Colors.red);
      }
    } catch (e) {
      Get.back();
      CustomToast.getToast("Failed!", "Try Again", Colors.red);
    }
  }
}
