// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/models/DuosTest/duosChallenge.dart';

import '../../utils/apiEndpoints.dart';

class DTController extends GetxController {
  var isLoading = false.obs;
  var isLoadingLive = false.obs;
  var isLoadingInProgress = false.obs;
  var isLoadingAttempted = false.obs;
  var tests = [].obs;
  var live = [].obs;
  var progress = [].obs;
  var Attempted = [].obs;
  var course = 'UPSC'.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Timer.periodic(Duration(seconds: 15), (timer) {
    //   fetchData();
    // });
    fetchLiveDuos();
    fetchUnattemptedDuos();
    fetchAttemptedDuos();
  }

  void fetchLiveDuos() async {
    try {
      isLoadingLive(true);
      http.Response response = await http.get(
        Uri.tryParse(ApiEndpoints.baseUrl + ApiEndpoints.liveDuos)!,
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
          'Course-Name': 'SSC',
          //course.value
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString());
        tests.clear();
        live.clear();
        var t = result['live_duos_challenges']
            .map((product) => DuosChallenge.fromJson(product))
            .toList();
        tests.addAll(t);
        live.addAll(t);
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (e) {
      print("Fetching Unsuccessful, error is $e");
    } finally {
      isLoadingLive(false);
    }
  }

  void fetchUnattemptedDuos() async {
    try {
      isLoadingInProgress(true);
      http.Response response = await http.get(
        Uri.tryParse(ApiEndpoints.baseUrl + ApiEndpoints.unattemptedDuos)!,
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
          'Course-Name': 'SSC',
          //course.value
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString());
        tests.clear();
        progress.clear();
        var t = result['in-progress_duos_challenges']
            .map((product) => DuosChallenge.fromJson(product))
            .toList();
        tests.addAll(t);
        progress.addAll(t);
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (e) {
      log("Fetching Unsuccessful, error is $e");
    } finally {
      isLoadingInProgress(false);
    }
  }

  void fetchAttemptedDuos() async {
    try {
      isLoadingAttempted(true);
      http.Response response = await http.get(
        Uri.tryParse(ApiEndpoints.baseUrl + ApiEndpoints.attmptedDuos)!,
        headers: {
          'Phone-Number': Get.find<UserController>().phone.value,
          'Course-Name': 'SSC',
          //course.value
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString());
        tests.clear();
        Attempted.clear();
        var t = result['completed_duos_challenges']
            .map((product) => DuosChallenge.fromJson(product))
            .toList();
        tests.addAll(t);
        Attempted.addAll(t);
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (e) {
      print("Fetching Unsuccessful, error is $e");
    } finally {
      isLoadingAttempted(false);
    }
  }
}
