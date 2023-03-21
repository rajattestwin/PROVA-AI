// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Titles extends StatelessWidget {
  String title;
  IconData? icon;
  bool? see;
  Function()? onTapped;
  Titles({
    super.key,
    required this.title,
    this.icon,
    this.onTapped,
    this.see = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              icon != null
                  ? Icon(icon, color: Theme.of(context).primaryColor)
                  : Container(),
            ],
          ),
          see == true
              ? TextButton(
                  onPressed: onTapped,
                  child: Text(
                    "See all",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 30,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
