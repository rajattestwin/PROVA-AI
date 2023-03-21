// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleVal extends StatelessWidget {
  String val;

  TitleVal({super.key, required this.val});

  @override
  Widget build(BuildContext context) {
    return Text(
      val,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 30,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
