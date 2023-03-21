import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provaai/bindings/Auth/authBinding.dart';
import 'package:provaai/screens/Login/phone_login.dart';
import 'package:provaai/screens/OnBoarding/splash_screen.dart';
import 'package:provaai/screens/Play/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prova AI',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 109, 18, 255),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      home: const SplashScreen(),
      initialBinding: AuthBinding(),
    );
  }
}
