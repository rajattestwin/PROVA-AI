// ignore_for_file: file_names, unnecessary_overrides

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:provaai/models/walletBalance.dart';
import 'package:provaai/screens/Login/phone_login.dart';
import 'package:provaai/utils/apiEndpoints.dart';
import 'package:provaai/utils/customToast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var loggedStatus = ''.obs;
  var phone = '+916377577809'.obs;
  var verifying = false.obs;
  var name = ''.obs;
  var avatarIndex = ''.obs;
  var balance = WalletBalance().obs;

  var courses = [].obs;
  var coursesLoading = false.obs;

  var currChallengeId = 0.obs;

  final _otplessFlutterPlugin = Otpless();

  @override
  void onInit() {
    super.onInit();
    getCoursesList();
    initPlatformState();
  }

  void initiateWhatsappLogin(String intentUrl) async {
    var result =
        await _otplessFlutterPlugin.loginUsingWhatsapp(intentUrl: intentUrl);
    switch (result['code']) {
      case "581":
        //Get.snackbar("Failed", result['message'].toString());
        break;
      default:
        log("Not Receving ID");
    }
  }

  alreadyLoggedIngetDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.profile),
        headers: {
          "Phone-Number": prefs.getString('phone_number').toString(),
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['status'] == 'Success') {
          name.value = json['name'];
          avatarIndex.value = json['avatar'];
          await getWalletBalance();
        } else {
          CustomToast.getToast("Oops!", "It's not you it's us!", Colors.red);
        }
      } else {
        CustomToast.getToast("Oops!", "It's not you it's us!", Colors.red);
      }
    } catch (e) {
      CustomToast.getToast("Oops!", "It's not you it's us!", Colors.red);
    }
  }

  Future<void> initPlatformState() async {
    _otplessFlutterPlugin.authStream.listen((token) {
      //print(token);
      log("WaId : $token");
      if (token!.isNotEmpty) {
        //Navigation
        Get.dialog(const Center(
          child: CircularProgressIndicator(),
        ));
        getDetails(token);
        //Get.offAll(() => const Verifying(), arguments: [token]);
      }
    });
  }

  getDetails(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/profile/get_whatsapp_token/'),
        headers: {
          'Whatsapp-Token': token,
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var existance = json['message'];
        if (existance == 'Exists' || existance == 'Already Logged In') {
          verifying.value = true;
          phone.value = json['phone_number'];
          prefs.setString('phone_number', phone.value);
          name.value = json['name'];
          avatarIndex.value = json['avatar'];
          //log(phone.value);

          getWalletBalance();
          //log(json);
        } else {
          verifying.value = false;
          phone.value = json['phone_number'];
          prefs.setString('phone_number', phone.value);
        }
        //Get.offAll(() => Root());
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  logOut() async {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.logOut,
        ),
        body: {
          'phone_number': phone.value,
        });
    if (jsonDecode(response.body)['status'] == 'Success') {
      prefs.setString('loggedStatus', "loggedOut");
      loggedStatus.value = 'loggedOut';
      Get.offAll(const Login(),
          transition: Transition.fadeIn, duration: const Duration(seconds: 1));
      CustomToast.getToast(
        jsonDecode(response.body)['status'],
        jsonDecode(response.body)['message'],
        Colors.green,
      );
    } else {
      CustomToast.getToast(
        jsonDecode(response.body)['status'],
        jsonDecode(response.body)['message'],
        Colors.red,
      );
    }
  }

  Future<void> getWalletBalance() async {
    try {
      var res = await http.get(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.walletbalance),
        headers: {
          'Phone-Number': phone.value,
        },
      );
      if (res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        if (resbody['status'] == 'Success') {
          balance.value = WalletBalance.fromJson(resbody);
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  getCoursesList() async {
    try {
      coursesLoading(true);
      var response = await http.get(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getCourses),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['status'] == 'Success') {
          courses.clear();
          courses.addAll(json['eng_courses'].toList());
          //print(courses);
        }
      }
    } catch (e) {
      //log("Failed" + e.toString());
    } finally {
      coursesLoading(false);
    }
  }
}
