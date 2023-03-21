// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryListItem extends StatelessWidget {
  String txt, img, title;
  Color clr;
  Function()? onTapped;
  CategoryListItem({
    super.key,
    required this.txt,
    required this.img,
    required this.title,
    required this.clr,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: clr,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  child: Center(
                    child: Text(
                      txt,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 22.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -10,
                bottom: 0,
                top: 0,
                child: Image.asset(
                  "assets/icons/Earn/$img.png",
                  scale: 0.9,
                ),
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
