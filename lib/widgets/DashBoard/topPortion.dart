// ignore_for_file: must_be_immutable, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopPortion extends StatefulWidget {
  String testname, creator, time, date;
  TopPortion({
    super.key,
    required this.testname,
    required this.creator,
    required this.time,
    required this.date,
  });

  @override
  State<TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends State<TopPortion> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border.all(
              color: Color.fromRGBO(127, 1, 252, 0.25),
            ),
            color: Color.fromARGB(255, 241, 238, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/DashBoard/upcomingTest.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.testname,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Date: ${widget.date}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 101, 101, 101),
                            fontSize: MediaQuery.of(context).size.width / 36,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "",
                            style: TextStyle(
                              color: Color.fromARGB(255, 241, 238, 255),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 65,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Share",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              45,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
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
        ),
        widget.time != "null"
            ? Positioned(
                top: 5,
                right: 16,
                child: Text(
                  "STARTS IN: ${widget.time}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width / 45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
