// ignore_for_file: prefer_const_constructors

// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provaai/controllers/Auth/authController.dart';
import 'package:provaai/widgets/Login/login_course.dart';
import 'avatar.dart';

class WelcomeTestWin extends StatefulWidget {
  const WelcomeTestWin({super.key});

  @override
  State<WelcomeTestWin> createState() => _WelcomeTestWinState();
}

class _WelcomeTestWinState extends State<WelcomeTestWin> {
  //selected index
  // CreateProfileController createProfileController =
  //     Get.put(CreateProfileController());
  final c = Get.put(AuthController());
  late int selectedIndex;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    selectedIndex = -1;
  }

  List<CourseDataModel> courseData = <CourseDataModel>[
    CourseDataModel(
        imgLocation: "assets/images/Courses/UPSC.png",
        isSelected: false,
        name: "UPSC"),
    CourseDataModel(
        imgLocation: "assets/images/Courses/CAT.png",
        isSelected: false,
        name: "SSC"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Background/choosecoursebg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // ignore: duplicate_ignore
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  // Image.asset('assets/images/pic4.png'),

                  RichText(
                    text: TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'TestWin',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: Color(0xff7F01FC),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Select a course you want to pursue',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  Expanded(
                    child: GridView.builder(
                      itemCount: courseData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? 3
                              : 5),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });

                            for (int i = 0; i < courseData.length; i++) {
                              if (i != selectedIndex) {
                                courseData[i].isSelected = false;
                              } else {
                                courseData[i].isSelected =
                                    !courseData[i].isSelected;
                              }
                            }
                          },
                          child: LoginCourse(
                              isSelected: courseData[index].isSelected,
                              image: courseData[index].imgLocation,
                              text: courseData[index].name),
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedIndex == -1) {
                          Get.snackbar("Oops!", "Select a Course");
                        } else {
                          c.course.value = courseData[selectedIndex].name;
                          Get.to(MyAvatar());
                        }
                      },
                      // ignore: sort_child_properties_last
                      child: const Text('Next'),
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        backgroundColor: Color(0xff7F01FC),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDataModel {
  String name;
  String imgLocation;
  bool isSelected;

  CourseDataModel(
      {required this.imgLocation,
      required this.isSelected,
      required this.name});
}
