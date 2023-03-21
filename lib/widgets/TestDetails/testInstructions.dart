// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestInstructions extends StatelessWidget {
  const TestInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    var inst = [
      "4 Marks are awarded for correct attempt and -1 for incorrect attempt",
      "Tap on the options to select the correct ansewer",
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GridView.builder(
        clipBehavior: Clip.none,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 50,
          childAspectRatio: 4.5 / 1,
        ),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 231, 245),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -30,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 30,
                  child: Text(
                    (index + 1).toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      inst[index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
