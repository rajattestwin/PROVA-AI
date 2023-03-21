// ignore_for_file: unused_catch_clause

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/models/Questions/questionsDetailResponse.dart';
import 'package:provaai/screens/Play/testPage.dart';
import 'package:provaai/utils/apiEndpoints.dart';
import 'package:provaai/utils/customToast.dart';

class GiveTestController extends GetxController {
  var questionOptionsResponse = QuestionOptionsResponse().obs;
  var questions = [].obs;
  var options = [].obs;

  getQuestionDetail(String challengeId, String type, String status) async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
      var response = await http.get(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getQuestions),
        headers: {
          "Phone-Number": Get.find<UserController>().phone.value,
          'Challenge-Id': challengeId,
          'Type': type,
        },
      );
      if (response.statusCode == 200) {
        var questionsJson = jsonDecode(response.body);
        if (questionsJson['status'] == 'Success') {
          questionOptionsResponse.value =
              QuestionOptionsResponse.fromJson(questionsJson);
          questions.clear();
          questions.addAll(questionOptionsResponse.value.questions!.toList());
          for (var i = 0; i < questions.length; i++) {
            log(questions[i].quesId.toString());
          }
          Get.offAll(const TestPage(),
              arguments: [questions, challengeId, type, status]);
        } else {}
        log(questionsJson.toString());
        Get.back();
      } else {
        CustomToast.getToast("Failed!", "Try Again", Colors.red);
      }
    } on Exception catch (e) {
      Get.back();
      CustomToast.getToast("Failed!", e.toString(), Colors.red);
    } finally {}
  }
}
