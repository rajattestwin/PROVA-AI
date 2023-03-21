// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleNameTI extends StatelessWidget {
  String name;
  TitleNameTI({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 30,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 105, 105, 105),
        ),
      ),
    );
  }
}
