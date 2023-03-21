// ignore: depend_on_referenced_packages

// ignore_for_file: prefer_const_constructors

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provaai/controllers/Auth/authController.dart';
import '../../widgets/Login/login_avatar.dart';

class MyAvatar extends StatefulWidget {
  const MyAvatar({super.key});

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}

class _MyAvatarState extends State<MyAvatar> {
  late int selectedIndex;
  // CreateProfileController createProfileController =
  //     Get.put(CreateProfileController());
  final c = Get.put(AuthController());
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
    selectedIndex = -1;
  }

  List<AvatarDataModel> avatarData = <AvatarDataModel>[
    AvatarDataModel(imgLocation: "assets/avatar/1.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/2.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/3.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/4.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/5.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/6.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/7.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/8.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/9.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/10.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/11.png", isSelected: false),
    AvatarDataModel(imgLocation: "assets/avatar/12.png", isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_declarations, unused_local_variable
    final circularProgressIndicator = const CircularProgressIndicator();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset("assets/images/Background/avatarbg.png"),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.024),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: duplicate_ignore
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.001),
                    child: Text(
                      "Choose an Avatar",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      itemCount: avatarData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? 3
                            : 4,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });

                            for (int i = 0; i < avatarData.length; i++) {
                              if (i != selectedIndex) {
                                avatarData[i].isSelected = false;
                              } else {
                                avatarData[i].isSelected =
                                    !avatarData[i].isSelected;
                              }
                            }
                          },
                          child: LoginAvatar(
                            isSelected: avatarData[index].isSelected,
                            avatarImage: avatarData[index].imgLocation,
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.009),
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedIndex == -1) {
                            Get.snackbar("Oops!", "Select an Avatar");
                          } else {
                            c.avatar.value = selectedIndex;
                            c.registerStudent();
                            //Get.to(DashBoard());
                          }
                        },
                        // ignore: sort_child_properties_last
                        child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          backgroundColor: const Color(0xff7F01FC),
                        ),
                      ),
                    ),
                  ),
                  // PrimaryTextButton(
                  //   text: "Next",
                  //   todo: () async {
                  //     createProfileController.avatar.value =
                  //         selectedIndex.toString();

                  //     circularProgressIndicator;
                  //     var res =
                  //         await Instances.createProfileController.createUser();
                  //     //Navigator.pop(context);
                  //     if (res == 'Dashboard') {
                  //       //Get.to(DashboardScreen());
                  //     }
                  //     Navigator.pushReplacementNamed(
                  //         context, MyRoutes.dashboardscreen);
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarDataModel {
  String imgLocation;
  bool isSelected;

  AvatarDataModel({
    required this.imgLocation,
    required this.isSelected,
  });
}
