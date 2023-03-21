// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleValTI extends StatelessWidget {
  String val;

  TitleValTI({super.key, required this.val});

  @override
  Widget build(BuildContext context) {
    return Text(
      val,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 22.5,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
