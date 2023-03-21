// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/CreateTest/createTestController.dart';

class SlotsWidget extends StatefulWidget {
  const SlotsWidget({super.key});

  @override
  State<SlotsWidget> createState() => _SlotsWidgetState();
}

class _SlotsWidgetState extends State<SlotsWidget> {
  late CreateTestController controller;

  int count = 3;

  void increment() {
    setState(() {
      count += 1;
      controller.slots.value = count;
    });
  }

  void decrement() {
    setState(() {
      count > 3 ? count -= 1 : null;
    });
    controller.slots.value = count;
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(CreateTestController());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: decrement,
          child: Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 7,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 243, 243),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 14,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 243, 243, 243),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width / 25,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: increment,
          child: Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 7,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 243, 243),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
