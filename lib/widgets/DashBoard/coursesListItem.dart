// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseListItem extends StatefulWidget {
  String title;
  bool isSelected;
  CourseListItem({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  State<CourseListItem> createState() => _CourseListItemState();
}

class _CourseListItemState extends State<CourseListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(3),
        elevation: 1,
        child: Container(
          width: 64,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Theme.of(context).primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                widget.title,
                style: GoogleFonts.archivo(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
