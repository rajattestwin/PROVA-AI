import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/Faq/faqController.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  late FaqController faqController;

  @override
  void initState() {
    super.initState();
    faqController = Get.put(FaqController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => faqController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.024),
                                  child: Text(
                                    "ANSWERS FOR YOUR QUESTIONS",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: Image.asset(
                                  "assets/images/FaqScreen/faq.png",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: faqController.faqs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.024),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.012,
                                ),
                              ),
                              child: Discription(
                                title: faqController.faqs[index].title,
                                subtitle: faqController.faqs[index].description,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class Discription extends StatelessWidget {
  String title;
  String subtitle;
  Discription({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.018),
          child: Text(
            subtitle,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
