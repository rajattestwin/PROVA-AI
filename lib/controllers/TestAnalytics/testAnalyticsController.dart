import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/screens/TestAnalytics/testanalytics.dart';

import '../../models/TestAnalytics/testAnalyticsClass.dart';
import '../../utils/apiEndpoints.dart';
import '../User/userController.dart';

class TestAnalyticsController extends GetxController {
  TestAnalyticsClass? testAnalyticsClass;
  List<QuestionsDetail>? questionsDetail;
  List<Leaderboard>? leaderboard;
  var isLoading = false.obs;

  getTestAnalysis(String challenge_Id, String type) async {
    // try {

    // } catch (e) {}
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    var result = await http.get(
      Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.testAnalytics),
      headers: {
        'Phone-Number': Get.find<UserController>().phone.value,
        'Challenge-Id': challenge_Id,
        'Type': type,
      },
    );
    if (result.statusCode == 200) {
      var json = jsonDecode(result.body);
      log(json.toString());
      testAnalyticsClass = TestAnalyticsClass.fromJson(json);
      questionsDetail = testAnalyticsClass!.questionsDetail;
      leaderboard = testAnalyticsClass!.leaderboard;
      Get.to(
        const TestAnalytics(),
        arguments: [testAnalyticsClass, questionsDetail, leaderboard],
      );
    } else {}
  }
}
