// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleTestTF extends StatefulWidget {
  String title;
  ScheduleTestTF({super.key, required this.title});

  @override
  State<ScheduleTestTF> createState() => _ScheduleTestTFState();
}

class _ScheduleTestTFState extends State<ScheduleTestTF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            keyboardType: widget.title == 'Slots'
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter ${widget.title}",
              hintStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width / 28,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            cursorColor: Colors.black12,
          ),
        ),
      ),
    );
  }
}
