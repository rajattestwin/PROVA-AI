// ignore_for_file: prefer_const_constructors

// ignore: depend_on_referenced_packages
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provaai/controllers/Auth/authController.dart';
import 'package:provaai/utils/customToast.dart';

import 'phone_login.dart';
import 'welcome_testwin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  // final createProfileController = Get.put(CreateProfileController());

  String message = '';

  void validateEmail(String enteredEmail) {
    if (EmailValidator.validate(enteredEmail)) {
      setState(() {
        message = 'Ok';
      });
    } else {
      setState(() {
        message = 'Please enter a valid email address!';
      });
    }
  }

  String dropdownValue = 'Select State';

  final c = Get.put(AuthController());

  String stateValue = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ignore: avoid_unnecessary_containers
        // body:
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/Background/phonelogin_bg.svg",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.024),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'TestWin',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    color: Color(0xff7F01FC),
                                    fontWeight: FontWeight.bold)),
                          ],

                          // textAlign: TextAlign.right
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Sign Up and Manage your account, check notifications, comment on videos and more.',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name',
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email ID',
                    ),
                    onChanged: (enteredEmail) => validateEmail(enteredEmail),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 11,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 241, 241, 241),
                        ),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Select State',
                          "Andhra Pradesh",
                          "Arunachal Pradesh ",
                          "Assam",
                          "Bihar",
                          "Chhattisgarh",
                          "Goa",
                          "Gujarat",
                          "Haryana",
                          "Himachal Pradesh",
                          "Jammu and Kashmir",
                          "Jharkhand",
                          "Karnataka",
                          "Kerala",
                          "Madhya Pradesh",
                          "Maharashtra",
                          "Manipur",
                          "Meghalaya",
                          "Mizoram",
                          "Nagaland",
                          "Odisha",
                          "Punjab",
                          "Rajasthan",
                          "Sikkim",
                          "Tamil Nadu",
                          "Telangana",
                          "Tripura",
                          "Uttar Pradesh",
                          "Uttarakhand",
                          "West Bengal",
                          "Andaman and Nicobar Islands",
                          "Chandigarh",
                          "Dadra and Nagar Haveli",
                          "Daman and Diu",
                          "Lakshadweep",
                          "New Delhi",
                          "Puducherry",
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.024),
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            dropdownValue == 'Select State') {
                          CustomToast.getToast(
                            "Invalid",
                            "You forgot to fill all details",
                            Colors.red,
                          );
                        } else {
                          if (message == 'Ok') {
                            c.name.value = nameController.text;
                            c.email.value = emailController.text;
                            c.state.value = dropdownValue;
                            Get.to(WelcomeTestWin());
                          } else {
                            CustomToast.getToast(
                                "Invalid", message, Colors.red);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff7F01FC),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
