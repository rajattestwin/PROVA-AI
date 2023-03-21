import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/screens/Login/phone_login.dart';
import 'package:provaai/screens/Play/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var loggedStatus = prefs.getString('loggedStatus');
      await prefs.setString('loggedStatus', 'loggedOut');
      if (loggedStatus == null) {
        await prefs.setString('loggedStatus', 'loggedOut');
        Get.offAll(() => const OnboardingScreen());
      } else if (loggedStatus == 'loggedOut') {
        Get.find<UserController>().loggedStatus.value = 'loggedOut';
        Get.offAll(() => const Login());
      } else {
        Get.find<UserController>().loggedStatus.value = 'loggedIn';
        Get.find<UserController>().phone.value =
            prefs.getString('phone_number').toString();
        Get.find<UserController>().alreadyLoggedIngetDetails();
        Get.offAll(() => const DashBoardScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff7F01FC),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logowhiteProva.png",
                height: MediaQuery.of(context).size.height / 9,
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  "Prova AI",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text(
                "AI Learning",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
