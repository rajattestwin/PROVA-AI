// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/screens/Play/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/logoProva.png",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Welcome To',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width / 15,
                              ),
                              /*defining default style is optional */
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' ProvaAI',
                                  style: GoogleFonts.inter(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        "Sign In and Manage your account, check notifications, comment on videos and more.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(80, 204, 93, 0.8),
                      ),
                      onPressed: () {
                        //Get.to(DashBoardScreen());
                        Get.find<UserController>().initiateWhatsappLogin(
                          "https://testwin.authlink.me?redirectUri=otpless://testwin",
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.whatsapp,
                                size: 26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Login With Whatsapp",
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          DashBoardScreen(),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Read our ',
                                style: GoogleFonts.archivo(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 32,
                                ),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Privacy Policy ',
                                    style: GoogleFonts.archivo(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'and ',
                                    style: GoogleFonts.archivo(
                                      color: Colors.grey,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terma & Conditions',
                                    style: GoogleFonts.archivo(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
