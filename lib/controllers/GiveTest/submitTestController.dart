// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/screens/Play/dashboard.dart';
import 'package:provaai/utils/customToast.dart';

import '../../utils/apiEndpoints.dart';

class SubmitTestController extends GetxController {
  var submitting = false.obs;

  submitChallenge(
      List<int> question_Ids,
      List<int> options_Ids,
      int time_taken,
      List<int> is_Attempted,
      int challenge_Id,
      String type,
      String status) async {
    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      var detail = jsonEncode(
        {
          'challenge_id': jsonEncode(challenge_Id),
          'questions_response': {
            'question_id': jsonEncode(question_Ids),
            'option_attempted_id': jsonEncode(options_Ids),
            'attempt_duration': jsonEncode(List<int>.filled(10, 0)),
            'is_attempted': jsonEncode(is_Attempted),
          },
          'total_attempt_duration': jsonEncode(time_taken),
          'type': type,
        },
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.submitChallenge),
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: detail,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == 'Success') {
          CustomToast.getToast("Submitted!",
              "Test has been successfully submitted!", Colors.purple);
          if (type == 'D') {
            if (status == "Live") {
              try {
                var rewardres = await http.get(
                    Uri.parse(
                        ApiEndpoints.baseUrl + ApiEndpoints.getChallengeReward),
                    headers: {
                      'Phone-Number': Get.find<UserController>().phone.value,
                      'Challenge-Id': challenge_Id.toString(),
                      'Type': type,
                    });
                if (rewardres.statusCode == 200) {
                  var jsonReward = jsonDecode(rewardres.body);
                  log(jsonReward.toString());
                  if (jsonReward['status'] == "Success") {
                    if (jsonReward['winning_status'] == "Won") {
                      CustomToast.getToast(
                        "You Won",
                        "Better Luck Next Time",
                        Colors.green,
                      );
                      Get.offAll(DashBoardScreen());
                    } else {
                      CustomToast.getToast(
                        "You Lost",
                        "Better Luck Next Time",
                        Colors.red,
                      );
                      Get.offAll(const DashBoardScreen());
                    }
                  } else {}
                }
              } catch (e) {}
            } else {
              Get.offAll(const DashBoardScreen());
            }
          }
        } else {
          Get.back();
          //log(result['message']);
          CustomToast.getToast(result['status'], result['message'], Colors.red);
        }
      } else {
        Get.back();
        log(response.statusCode.toString());
        CustomToast.getToast("Not Submitted", "Try Again", Colors.red);
      }
    } catch (e) {
      Get.back();
      CustomToast.getToast("Not Submitted", "Try Again", Colors.red);
    }
  }
}
