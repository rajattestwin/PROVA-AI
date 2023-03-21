// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, file_names, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/PlayTest/duosJoinController.dart';
import 'package:provaai/models/DuosTest/duosChallenge.dart';
import 'package:provaai/screens/Play/PlayTest.dart';
import 'package:provaai/widgets/TestDetails/testInstructions.dart';
import 'package:provaai/widgets/TestDetails/titleNameTI.dart';

class DuosDetails extends StatefulWidget {
  DuosChallenge duosChallenge;
  DuosDetails({super.key, required this.duosChallenge});

  @override
  State<DuosDetails> createState() => _DuosDetailsState();
}

class _DuosDetailsState extends State<DuosDetails> {
  late DuosJoinController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DuosJoinController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "One on One Test",
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
                    widget.duosChallenge.courseName.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width / 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.duosChallenge.title.toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            32.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TitleNameTI(
                                  name:
                                      "Date: ${widget.duosChallenge.created_date}"),
                              SizedBox(height: 10),
                              TitleNameTI(name: "Course"),
                              Text(
                                widget.duosChallenge.courseName.toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            32.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleNameTI(name: "Created By"),
                                Text(
                                  widget.duosChallenge.challengerName
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              32.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TitleNameTI(name: "Subject"),
                                Text(
                                  widget.duosChallenge.subjectName.toString(),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              32.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 24.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/icons/Earn/rupee.png"),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.duosChallenge.winningAmt.toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'on win',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                36,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () async {
                              if (widget.duosChallenge.challengeStatus ==
                                  'Live') {
                                controller.joinDuos(widget.duosChallenge);
                              } else {
                                Get.to(
                                  PlayTestScreen(
                                    dc: widget.duosChallenge,
                                    gc: null,
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  widget.duosChallenge.challengeStatus == 'Live'
                                      ? "Join \u{20B9}${widget.duosChallenge.entryAmt}"
                                      : "Join Now",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            "Test Details",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TestInstructions()
            ],
          ),
        ),
      ),
    );
  }
}
