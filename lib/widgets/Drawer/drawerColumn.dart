// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/web/web_icon_generator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/User/userController.dart';
import 'package:provaai/screens/Faq/faq.dart';
import 'package:provaai/widgets/categoryListItem.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DashBoard/titles.dart';
import 'drawerCard.dart';

class DrawerColumn extends StatefulWidget {
  const DrawerColumn({super.key});

  @override
  State<DrawerColumn> createState() => _DrawerColumnState();
}

class _DrawerColumnState extends State<DrawerColumn> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   textEditingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.7,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        //"assets/icons/Avatars/${Get.find<UserController>().avatarIndex.value}.png",
                        "assets/icons/Avatars/0.png",
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text(Get.find<UserController>().name.value),
                        SizedBox(
                          height: 2,
                        ),
                        Text(Get.find<UserController>().phone.value),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => CupertinoAlertDialog(
                                title: Text("Confirm, log out?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.find<UserController>().logOut();
                                    },
                                    child: Text("Confirm"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // CategoryList(
              //   txt: 'Wallet',
              // ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CategoryListItem(
                      txt: "0",
                      img: "rupee",
                      title: "Coins",
                      clr: Colors.green,
                      onTapped: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Titles(
                  title: "Support",
                  see: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  children: [
                    DrawerCard(
                      title: "FAQ",
                      img: "faq",
                      onTapped: () {
                        Get.to(() => Faq());
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => CupertinoAlertDialog(
                            title: Text("Confirm, log out?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.find<UserController>().logOut();
                                },
                                child: Text("Confirm"),
                              ),
                            ],
                          ),
                        );
                        //;
                      },
                      child: Text(
                        "Sign Out",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
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
}
