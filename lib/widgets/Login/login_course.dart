// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LoginCourse extends StatefulWidget {
  bool isSelected;
  String image;
  String text;
  LoginCourse(
      {super.key,
      required this.isSelected,
      required this.image,
      required this.text});

  @override
  State<LoginCourse> createState() => _LoginCourseState();
}

class _LoginCourseState extends State<LoginCourse> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 5.5,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.isSelected
                  ? Color.fromARGB(
                      255, 109, 18, 255) //AppColors.appSecondaryColor
                  : const Color.fromARGB(253, 242, 231, 249)),
          child: Center(
            child: widget.text != "SSC"
                ? Image.asset(
                    widget.image,
                    width: MediaQuery.of(context).size.width / 9,
                    fit: BoxFit.fill,
                  )
                : Text(
                    "SSC",
                    style: GoogleFonts.archivo(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        )
      ],
    );
  }
}
