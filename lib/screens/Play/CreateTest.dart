// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unused_field, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print, avoid_unnecessary_containers, sort_child_properties_last

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provaai/controllers/CreateTest/createTestController.dart';
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/utils/customToast.dart';
import 'package:provaai/widgets/CreateTest/entryAmount.dart';
import 'package:provaai/widgets/CreateTest/slots.dart';
import 'package:provaai/widgets/DashBoard/titles.dart';

class CreateTest extends StatefulWidget {
  const CreateTest({super.key});

  @override
  State<CreateTest> createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  int selectedIndex = -1;
  int chooseTestIndex = 0;

  String? selectedSubject;
  int? selectedSubjectId;

  String? selectedChapter;
  int? selectedChapterId;

  String _date = "Not set";
  String _time = "Not set";

  late CreateTestController _createTestController;

  TextEditingController timeinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    //AmplitudeClass.mainScreenLog("CREATE_TEST_SCREEN");
    _createTestController = Get.put(CreateTestController());
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  var chooseTest = {
    0: "DUOS",
    1: "GROUP",
  };

  var course = {
    0: "UPSC",
    1: "SSC",
  };

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
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Create Test",
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
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: [
                //Course Selection

                Titles(
                  title: "Select Course",
                  see: false,
                ),
                GridView.builder(
                  itemCount: Get.find<UserController>().courses.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            selectedIndex = index;
                            // AmplitudeClass.eventClick(
                            //     "CREATE_TEST_SELECTED_COURSE_${Get.find<UserController>().courses[index]}");
                            _createTestController.chapNames.clear();
                            _createTestController.getSubjectName(
                              Get.find<UserController>()
                                  .courses[index]
                                  .toString(),
                            );
                            selectedSubject = null;
                            selectedChapter = null;
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 242, 229, 255),
                          borderRadius: BorderRadius.circular(10),
                          border: index == selectedIndex
                              ? Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 10)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            Get.find<UserController>()
                                .courses[index]
                                .toString(),
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //Subject Selection

                Obx(
                  () => _createTestController.subsNames.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            Titles(
                              title: "Select Subject",
                              see: false,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedSubject,
                                      isExpanded: true,
                                      style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                      items: _createTestController.subsNames
                                          .cast<String>()
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                      hint: Text(
                                        "Select Subject",
                                        style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              28,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      onChanged: (String? value) {
                                        setState(
                                          () {
                                            selectedChapter = null;
                                            selectedSubject = value;

                                            selectedSubjectId =
                                                _createTestController.subsIds[
                                                    _createTestController
                                                        .subsNames
                                                        .indexOf(
                                                            selectedSubject)];
                                            log(selectedSubjectId.toString());
                                            _createTestController
                                                .getChapterName(
                                                    selectedSubjectId);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),

                //Chapter Selection

                Obx(
                  () => _createTestController.chapNames.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            Titles(
                              title: "Select Chapter",
                              see: false,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedChapter,
                                      isExpanded: true,
                                      style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                      items: _createTestController.chapNames
                                          .cast<String>()
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                      hint: Text(
                                        "Select Chapter",
                                        style: GoogleFonts.poppins(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              28,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      onChanged: (String? value) {
                                        setState(
                                          () {
                                            log(_createTestController.subsNames
                                                .toString());
                                            selectedChapter = value;
                                            selectedChapterId =
                                                _createTestController.chapIds[
                                                    _createTestController
                                                        .chapNames
                                                        .indexOf(
                                                            selectedChapter)];
                                            log(selectedChapterId.toString());
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),

                //Entry Amount

                Titles(
                  title: "Enter Entry Amount",
                  see: false,
                ),
                EntryAmountWidget(),

                //Test Type

                Titles(
                  title: "Choose Test",
                  see: false,
                ),
                GridView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          chooseTestIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 243, 243),
                          borderRadius: BorderRadius.circular(10),
                          border: index == chooseTestIndex
                              ? Border.all(color: Colors.black)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                chooseTest[index].toString(),
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "assets/icons/CreateTest/${chooseTest[index].toString().toLowerCase()}.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (chooseTestIndex != 0)
                  Titles(title: "Choose Slots", see: false),
                if (chooseTestIndex != 0) SlotsWidget(),

                if (chooseTestIndex != 0)
                  Titles(title: "Choose Date and Time", see: false),
                if (chooseTestIndex != 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: () {
                              // DatePicker.showDatePicker(
                              //   context,
                              //   theme: DatePickerTheme(
                              //     containerHeight: 210.0,
                              //   ),
                              //   showTitleActions: true,
                              //   minTime: DateTime(
                              //     DateTime.now().year,
                              //     DateTime.now().month,
                              //     DateTime.now().day,
                              //   ),
                              //   maxTime: DateTime(
                              //     DateTime.now().year,
                              //     DateTime.now().month,
                              //     DateTime.now().day + 1,
                              //   ),
                              //   onConfirm: (date) {
                              //     print('confirm $date');
                              //     if (date.month.toString().length == 1) {
                              //       if (date.day.toString().length == 1) {
                              //         _date =
                              //             '${date.year}-0${date.month}-0${date.day}';
                              //       } else {
                              //         _date =
                              //             '${date.year}-0${date.month}-${date.day}';
                              //       }
                              //     } else {
                              //       if (date.day.toString().length == 1) {
                              //         _date =
                              //             '${date.year}-0${date.month}-0${date.day}';
                              //       } else {
                              //         _date =
                              //             '${date.year}-${date.month}-${date.day}';
                              //       }
                              //     }
                              //     setState(() {});
                              //   },
                              //   currentTime: DateTime.now(),
                              //   locale: LocaleType.en,
                              // );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              size: 18.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day)
                                                  .toString()
                                                  .replaceAll(
                                                      " 00:00:00.000", "")
                                                  .trim(),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              size: 18.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(
                                              (DateTime.now().hour + 2)
                                                          .toString()
                                                          .length ==
                                                      1
                                                  ? "0${TimeOfDay.fromDateTime(DateTime.now()).hour + 2}:00:00"
                                                  : "${TimeOfDay.fromDateTime(DateTime.now()).hour + 2}:00:00",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),

                //Create Test Button

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (chooseTestIndex == 0) {
                        _createTestController.test_type.value = 'DUOS';

                        if (selectedSubject != null &&
                            selectedChapter != null) {
                          _createTestController.curr_chap_id.value =
                              selectedChapterId!;
                          _createTestController.createTest();
                        } else {
                          CustomToast.getToast(
                            "Error!",
                            "Select all required fields",
                            Colors.red,
                          );
                        }
                      } else {
                        _time = (DateTime.now().hour + 2).toString().length == 1
                            ? "0${TimeOfDay.fromDateTime(DateTime.now()).hour + 2}:00:00"
                            : "${TimeOfDay.fromDateTime(DateTime.now()).hour + 2}:00:00";
                        _date = DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day)
                            .toString()
                            .replaceAll(" 00:00:00.000", "")
                            .trim();
                        _createTestController.test_type.value = 'GROUP';
                        if (selectedSubject != null &&
                            selectedChapter != null) {
                          _createTestController.curr_chap_id.value =
                              selectedChapterId!;
                          _createTestController.start_time.value =
                              "$_date $_time";

                          _createTestController.createTest();
                        } else {
                          CustomToast.getToast(
                            "Error!",
                            "Select all required fields",
                            Colors.red,
                          );
                        }
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Create Test",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 25,
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
