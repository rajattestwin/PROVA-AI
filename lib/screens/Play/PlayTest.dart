// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/controllers/GiveTest/giveTestController.dart';
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/models/DuosTest/duosChallenge.dart';
import 'package:provaai/models/GroupTest/groupChallenge.dart';
import 'package:provaai/screens/Play/dashboard.dart';
import 'package:provaai/widgets/DashBoard/titleName.dart';
import 'package:provaai/widgets/TestDetails/testInstructions.dart';

class PlayTestScreen extends StatelessWidget {
  final controller = Get.put(GiveTestController());
  DuosChallenge? dc;
  GroupChallenges? gc;
  PlayTestScreen({
    super.key,
    required this.dc,
    required this.gc,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
            onPressed: () {
              Get.offAll(const DashBoardScreen());
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text(
            "Play Test",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width / 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      dc != null
                          ? dc!.courseName.toString()
                          : gc!.courseName.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Text(
                        dc != null
                            ? dc!.courseName.toString()
                            : gc!.courseName.toString(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    dc != null ? dc!.title.toString() : gc!.title.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 31,
                        height: 31,
                        child: CircleAvatar(
                            // backgroundImage: AssetImage(
                            //   "assets/icons/Avatars/${Get.find<UserController>().avatarIndex.value}.png",
                            // ),
                            ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dc != null
                                ? dc!.challengerName.toString()
                                : gc!.challengerName.toString(),
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TitleName(name: "Creator")
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                "10",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 25,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Questions",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Image.asset(
                                  "assets/icons/Earn/rupee.png",
                                ),
                              ),
                            ),
                            dc != null
                                ? Text(
                                    "+${dc!.winningAmt}",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    "${gc!.winningAmtUpto}",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "RULES",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TestInstructions(),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      log(dc!.challengeStatus.toString());
                      dc != null
                          ? controller.getQuestionDetail(
                              dc!.challengeId.toString(),
                              'D',
                              dc!.challengeStatus.toString(),
                            )
                          : controller.getQuestionDetail(
                              gc!.challengeId.toString(),
                              'G',
                              gc!.challengeStatus.toString(),
                            );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          gc != null
                              ? "Join Test in ${gc!.startTimeLeft}"
                              : "Join Test",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 22.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
