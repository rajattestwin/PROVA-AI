// ignore_for_file: file_names, empty_catches, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/models/CreateTest/latestChallenge.dart';
import 'package:provaai/models/CreateTest/subjects.dart';
import 'package:provaai/screens/Play/DuosDetails.dart';
import 'package:provaai/screens/Play/dashboard.dart';
import 'package:provaai/utils/apiEndpoints.dart';
import 'package:provaai/utils/customToast.dart';

class CreateTestController extends GetxController {
  var curr_subj_id = 0.obs;
  var curr_chap_id = 0.obs;
  var isLoading = false.obs;
  var slots = 3.obs;
  var entry_amt = 10.obs;
  var test_type = ''.obs;
  var start_time = ''.obs;
  List<dynamic>? tests;

  var subRes = SubjectsResponse().obs;
  var subjects = <Subject>[].obs;
  var subsNames = <String>[].obs;
  var subsIds = <int>[].obs;
  var chapRes = Chapters().obs;
  var chapNames = <String>[].obs;
  var chapIds = <int>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    //dropdownCourses();
  }

  createTest() async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
      );
      var response = await http.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.createChallenge),
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
        },
        body: {
          'chapter_id': curr_chap_id.value.toString(),
          'entry_amt': entry_amt.value.toString(),
          'challenge_type': test_type.value,
          'slots': slots.value.toString(),
          'start_time': start_time.value,
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['status'] == 'Success') {
          CustomToast.getToast("Successful", json['message'], Colors.green);
          Get.find<UserController>().getWalletBalance();
          if (test_type.value == 'DUOS') {
            getLatestChallenge();
          } else {
            Get.offAll(() => const DashBoardScreen());
          }
        } else {
          Get.back();
          CustomToast.getToast("Unsuccessful", json['message'], Colors.red);
        }
      } else {
        Get.back();
      }
    } on Exception catch (e) {
      Get.back();
      CustomToast.getToast("Unsuccessful", e.toString(), Colors.red);
    }
  }

  getSubjectName(String courseName) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      subsNames.clear();
      var result = await http.get(
        Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.subjectsApi,
        ),
        headers: {
          "Phone-Number": Get.find<UserController>().phone.value,
          "Course-Name": courseName,
        },
      );
      if (result.statusCode == 200) {
        subRes.value = SubjectsResponse.fromJson(jsonDecode(result.body));
        if (subRes.value.status == 'Success') {
          subjects.value = subRes.value.subjects!;
          subsNames.value =
              subjects.value.map((e) => e.subjName.toString()).toList();
          subsIds.value = subjects.value
              .map((e) => int.parse(e.subjId.toString()))
              .toList();
        } else {
          Get.snackbar("Failed", "Unable To Fetch Subjects");
        }
      } else {
        Get.snackbar("Failed!", "Try Again");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Failed!", e.toString());
    } finally {
      Get.back();
    }
  }

  getChapterName(int? subjectId) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      var result = await http.get(
        Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.chapterApi,
        ),
        headers: {
          "Subject-Id": subjectId.toString(),
        },
      );
      if (result.statusCode == 200) {
        chapRes.value = Chapters.fromJson(jsonDecode(result.body));
        if (chapRes.value.status == 'Success') {
          chapNames.value = chapRes.value.chapterNames!;
          chapIds.value = chapRes.value.chapterIds!;
        } else {
          Get.snackbar("Failed", "Unable To Fetch Subjects");
        }
      } else {
        Get.snackbar("Failed!", "Try Again");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Failed!", e.toString());
    } finally {
      Get.back();
    }
  }

  getLatestChallenge() async {
    try {
      var result = await http.get(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.latestChallenge),
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
          'Type': 'D',
        },
      );
      if (result.statusCode == 200) {
        LatestDuosChallengeResponse latestDuosChallengeResponse =
            LatestDuosChallengeResponse.fromJson(jsonDecode(result.body));
        Get.off(
          DuosDetails(
            duosChallenge: latestDuosChallengeResponse.latestduoschallenge![0]!,
          ),
        );
      } else {
        Get.snackbar("Unsuccessful", "Try Again");
      }
    } catch (e) {
      Get.snackbar("Unsuccessful", "Try Again!");
    }
  }
}
