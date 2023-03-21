// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/TestAnalytics/testAnalyticsController.dart';
import 'package:provaai/models/DuosTest/duosChallenge.dart';
import 'package:provaai/screens/Play/DuosDetails.dart';
import 'package:provaai/widgets/DashBoard/titleName.dart';
import 'package:provaai/widgets/DashBoard/titleVal.dart';

class DuosTestCard extends StatefulWidget {
  DuosChallenge duosChallenge;
  DuosTestCard({
    super.key,
    required this.duosChallenge,
  });

  @override
  State<DuosTestCard> createState() => _DuosTestCardState();
}

class _DuosTestCardState extends State<DuosTestCard> {
  late TestAnalyticsController testAnalyticsController;

  @override
  void initState() {
    testAnalyticsController = Get.put(TestAnalyticsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.duosChallenge.winningStatus.toString());
    return GestureDetector(
      onTap: () {
        log(widget.duosChallenge.winningStatus.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.duosChallenge.challengeStatus == 'Completed'
              ? widget.duosChallenge.winningStatus == "Won"
                  ? Colors.green
                  : widget.duosChallenge.winningStatus == 'Lost'
                      ? Colors.red
                      : Colors.white
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Colors.grey.shade400,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Created By : ${widget.duosChallenge.challengerName}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        // Icon(
                        //   Icons.person_add,
                        //   color: Colors.grey,
                        //   size: 20,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.duosChallenge.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 30,
                      ),
                    ),
                  ),
                  widget.duosChallenge.challengeStatus == "Completed"
                      ? Expanded(child: Container())
                      : Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "ENDS IN: ${widget.duosChallenge.activeTimeLeft}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 45,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleName(name: "Course"),
                        TitleVal(
                            val: widget.duosChallenge.courseName.toString()),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleName(name: "Subject"),
                        TitleVal(
                          val: widget.duosChallenge.subjectName.toString(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  widget.duosChallenge.challengeStatus == "Completed"
                      ? Expanded(
                          child: widget.duosChallenge.winningStatus == "Won"
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleName(name: "Won Amt"),
                                      TitleVal(
                                        val:
                                            '\u{20B9}${widget.duosChallenge.winningAmt}',
                                      ),
                                    ],
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleName(name: "Lost Amt"),
                                      TitleVal(
                                        val:
                                            '\u{20B9}${widget.duosChallenge.entryAmt}',
                                      ),
                                    ],
                                  ),
                                ),
                        )
                      : Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleName(name: "Entry Amt"),
                                TitleVal(
                                  val:
                                      '\u{20B9}${widget.duosChallenge.entryAmt}',
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                mainAxisAlignment:
                    widget.duosChallenge.challengeStatus != "Completed"
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                children: [
                  widget.duosChallenge.challengeStatus != "Completed"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleName(name: "Winning Amount"),
                            Text(
                              "\u{20B9}${widget.duosChallenge.winningAmt}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  widget.duosChallenge.challengeStatus != 'Completed'
                      ? widget.duosChallenge.challengeStatus == "In-Progress"
                          ? widget.duosChallenge.winningStatus != 'Active'
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      DuosDetails(
                                        duosChallenge: widget.duosChallenge,
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Text("Play Now"),
                                  ),
                                )
                              : Container()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Get.to(
                                  DuosDetails(
                                    duosChallenge: widget.duosChallenge,
                                  ),
                                );
                              },
                              child: Center(
                                child: Text("Play Now"),
                              ),
                            )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            testAnalyticsController.getTestAnalysis(
                              widget.duosChallenge.challengeId.toString(),
                              'D',
                            );
                          },
                          child: Center(
                            child: Text("See Results"),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
