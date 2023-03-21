// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/models/TestAnalytics/testAnalyticsClass.dart';
import 'package:provaai/screens/TestAnalytics/aiAnswers.dart';

class ReviewAnswer extends StatelessWidget {
  const ReviewAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<QuestionsDetail>? qd = Get.arguments[1];

    var t = ["Correct Option", "Selected Option"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Review Answers",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PageView.builder(
          allowImplicitScrolling: false,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          controller: controller,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Question ${index + 1}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16),
                //   child: AspectRatio(
                //     aspectRatio: 16 / 9,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Image.asset(
                //         "assets/icons/TestAnalytics/review.png",
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${qd![index].question}",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ListView.builder(
                        itemCount: 2,
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, idx) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              isThreeLine: true,
                              textColor: Colors.white,
                              tileColor: idx == 1
                                  ? qd[index].correctOption.toString().trim() ==
                                          qd[index]
                                              .selectedOption
                                              .toString()
                                              .trim()
                                      ? Colors.green
                                      : Colors.brown.shade400
                                  : Colors.green,
                              title: Text(t[idx]),
                              subtitle: Text(
                                idx == 0
                                    ? qd[index].correctOption.toString()
                                    : qd[index].selectedOption ??
                                        "Not Attempted",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.previousPage(
                                duration: Duration(microseconds: 10),
                                curve: Curves.bounceOut,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: index != 0 ? Colors.white : Colors.grey,
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
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.nextPage(
                                  duration: Duration(microseconds: 10),
                                  curve: Curves.bounceIn);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: index != 9
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
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
                                      "Next",
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AIanswers());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
