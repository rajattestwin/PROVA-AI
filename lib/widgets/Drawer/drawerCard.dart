// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerCard extends StatefulWidget {
  String title, img;
  Function()? onTapped;
  DrawerCard({
    super.key,
    required this.title,
    required this.img,
    this.onTapped,
  });

  @override
  State<DrawerCard> createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapped,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 242, 229, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Image.asset("assets/images/Drawer/${widget.img}.png"),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
