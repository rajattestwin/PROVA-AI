// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provaai/controllers/GiveTest/submitTestController.dart';
import 'package:provaai/utils/customToast.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with WidgetsBindingObserver {
  late PageController pageController;
  late SubmitTestController submitTestController;
  int outOfApp = 0;
  String ch = Get.arguments[1];
  String t = Get.arguments[2];
  String status = Get.arguments[3];
  int seconds = 300;
  Timer? timer;
  int currPage = 1;
  var questions = Get.arguments[0];
  List<int> tags = List<int>.filled(10, -1);

  List<int> question_Ids = List<int>.filled(10, 0);
  var options_Ids = List<int>.filled(10, -1);
  var time_taken = 300;
  var is_Attempted = List<int>.filled(10, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
    pageController = PageController();
    submitTestController = SubmitTestController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer!.cancel();
    pageController.dispose();
    submitTestController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (outOfApp == 0) {
          outOfApp = 1;
          CustomToast.getToast(
            "Submitting",
            "Your test is submitted because you got out off app!",
            Colors.red,
          );
          submit();
        }
        log("app in resumed");
        break;
      case AppLifecycleState.inactive:
        log("app in inactive");
        break;
      case AppLifecycleState.paused:
        log("app in paused");
        break;
      case AppLifecycleState.detached:
        log("app in detached");
        break;
    }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          submit();
        }
      });
    });
  }

  submitTest() {
    var skipped = '';
    log(ch.toString());
    log(t.toString());
    log(status.toString());
    for (var i = 0; i < 10; i++) {
      is_Attempted[i] = options_Ids[i] != -1 ? 1 : 0;
    }
    for (var i = 0; i < 10; i++) {
      if (is_Attempted[i] == 0) {
        skipped += '${i + 1},';
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Submit Test?"),
          content: is_Attempted.contains(0)
              ? Text("You have skipped question no. $skipped Are you sure?")
              : Text("Are you sure?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () async {
                for (var i = 0; i < 10; i++) {
                  question_Ids[i] = questions[i].quesId;
                }
                for (var i = 0; i < 10; i++) {
                  is_Attempted[i] = options_Ids[i] != -1 ? 1 : 0;
                }
                time_taken = 300 - seconds;
                log(question_Ids.toString());
                log(options_Ids.toString());
                log(time_taken.toString());
                log(is_Attempted.toString());
                log(ch);
                submitTestController.submitChallenge(
                  question_Ids,
                  options_Ids,
                  time_taken,
                  is_Attempted,
                  int.parse(ch),
                  t,
                  status,
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  submit() async {
    for (var i = 0; i < 10; i++) {
      question_Ids[i] = questions[i].quesId;
    }
    for (var i = 0; i < 10; i++) {
      is_Attempted[i] = options_Ids[i] != -1 ? 1 : 0;
    }
    time_taken = 300 - seconds;
    log(question_Ids.toString());
    log(options_Ids.toString());
    log(time_taken.toString());
    log(is_Attempted.toString());
    log(ch);
    await submitTestController.submitChallenge(
      question_Ids,
      options_Ids,
      time_taken,
      is_Attempted,
      int.parse(ch),
      t,
      status,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$currPage/10",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Colors.black,
                      ),
                    ),
                    Image.asset('assets/icons/Earn/testwin.png'),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currPage = value + 1;
                      });
                      log(value.toString());
                    },
                    itemCount: 10,
                    pageSnapping: true,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                questions[index].quesText ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, idx) {
                                return Material(
                                  elevation: 10,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      color: tags[currPage - 1] == idx
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      child: ListTile(
                                        selectedTileColor:
                                            Color.fromARGB(255, 127, 1, 252),
                                        tileColor: Colors.white,
                                        selectedColor: Colors.white,
                                        textColor: tags[currPage - 1] == idx
                                            ? Colors.white
                                            : Colors.black,
                                        onTap: () {
                                          setState(
                                            () {
                                              if (tags[currPage - 1] == idx) {
                                                tags[currPage - 1] = -1;
                                                options_Ids[currPage - 1] = -1;
                                              } else {
                                                tags[currPage - 1] = idx;
                                                options_Ids[currPage - 1] =
                                                    questions[currPage - 1]
                                                        .options![idx]
                                                        .id;
                                              }
                                            },
                                          );
                                          log(tags[currPage - 1].toString());
                                        },
                                        title: Text(getOpText(
                                            questions[currPage - 1]
                                                .options!)[idx]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currPage != 1
                          ? GestureDetector(
                              onTap: () {
                                pageController.previousPage(
                                  duration: Duration(microseconds: 10),
                                  curve: Curves.bounceOut,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Previous",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          if (currPage != 10) {
                            pageController.nextPage(
                              duration: Duration(microseconds: 10),
                              curve: Curves.bounceIn,
                            );
                          } else {
                            submitTest();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  currPage == 10 ? "Submit" : "Next",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearPercentIndicator(
                        percent: seconds / 300,
                        barRadius: const Radius.circular(10),
                        lineHeight: 20,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        progressColor: Theme.of(context).primaryColor,
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            seconds.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }

  getOpText(var op) {
    List<String> sop = ['', '', '', ''];
    for (var i = 0; i < 4; i++) {
      sop[i] = op[i].optionText ?? "";
    }
    return sop;
  }
}
