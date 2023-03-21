import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Login/phone_login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final data = [
    OnboardingElement(
        img: 'assets/images/Background/onboarding_pic1.svg',
        svgimg: 'assets/images/Background/onboarding_bg1.svg',
        title: 'LEARN',
        subtitle:
            'Unlock your potential: Learn, Play, Earn your way to success!',
        col: const Color(0xffFF725E)),
    OnboardingElement(
        img: 'assets/images/Background/onboarding_pic2.svg',
        svgimg: 'assets/images/Background/onboarding_bg2.svg',
        title: 'PLAY',
        subtitle:
            'Unlock your potential: Learn, Play, Earn your way to success!',
        col: const Color(0xff9553A0)),
    OnboardingElement(
        img: 'assets/images/Background/onboarding_pic3.svg',
        svgimg: 'assets/images/Background/onboarding_bg3.svg',
        title: 'GROW',
        subtitle:
            'Unlock your potential: Learn, Play, Earn your way to success!',
        col: const Color(0xff92E3A9))
  ];
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget buildPage({
    // required Color color,
    required Color textcolor,
    required String svgimage,
    required String img,
    required String title,
    // required Function function,
    required String subtitle,
  }) =>
      Stack(children: <Widget>[
        SvgPicture.asset(
          svgimage,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        SizedBox(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(img),
          Text(
            title,
            style: TextStyle(
              color: textcolor,
              fontSize: MediaQuery.of(context).size.height * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ])),
      ]);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          // color: Colors.blue,

          child: Column(children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() => isLastPage = index == 2);
                },
                children: [
                  for (var obj in data)
                    buildPage(
                        img: obj.img,
                        textcolor: obj.col,
                        svgimage: obj.svgimg,
                        title: obj.title,
                        subtitle: obj.subtitle)
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 10,
              child: isLastPage
                  ? Container(
                      color: const Color.fromARGB(146, 71, 180, 71),
                      child: TextButton(
                          child: Text(
                            'GET STARTED',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 237, 241, 241),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          }),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.003),
                      color: const Color.fromARGB(0, 136, 49, 49),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text('SKIP'),
                            onPressed: () => controller.jumpToPage(2),
                          ),
                          Center(
                              child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                          )),
                          Row(
                            children: [
                              TextButton(
                                child: const Text(
                                  'NEXT',
                                ),

                                // icon: Icon( Icons.arrow_forward_outlined, ),
                                onPressed: () => controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
            ),
          ]),
        ),
      ),
    );
  }
}

class OnboardingElement {
  String svgimg;
  String img;
  String title;
  String subtitle;
  Color col;
  OnboardingElement(
      {required this.svgimg,
      required this.img,
      required this.title,
      required this.subtitle,
      required this.col});
}
