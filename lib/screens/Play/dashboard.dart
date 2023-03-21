// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provaai/controllers/DuosTest/dtController.dart';
import 'package:provaai/widgets/DashBoard/DuosTestCard/duosTestCard.dart';
import 'package:provaai/widgets/Drawer/drawerColumn.dart';
import 'package:provaai/widgets/coverContainer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late DTController dtController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    dtController = Get.put(DTController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CoverContainer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                automaticIndicatorColorAdjustment: true,
                controller: tabController,
                tabs: [
                  Text(
                    "Live",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "In Progress",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Attempted",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(
                    () => dtController.isLoadingLive.value
                        ? const Center(child: CircularProgressIndicator())
                        : dtController.live.isEmpty
                            ? Image.asset("assets/icons/emptyGroup.png")
                            : SingleChildScrollView(
                                child: ListView.builder(
                                  itemCount: dtController.live.length,
                                  clipBehavior: Clip.hardEdge,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: DuosTestCard(
                                        duosChallenge: dtController.live[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                  Obx(
                    () => dtController.isLoadingInProgress.value
                        ? const Center(child: CircularProgressIndicator())
                        : dtController.progress.isEmpty
                            ? Image.asset("assets/icons/emptyGroup.png")
                            : SingleChildScrollView(
                                child: ListView.builder(
                                  itemCount: dtController.progress.length,
                                  clipBehavior: Clip.hardEdge,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: DuosTestCard(
                                        duosChallenge:
                                            dtController.progress[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                  Obx(
                    () => dtController.isLoadingAttempted.value
                        ? const Center(child: CircularProgressIndicator())
                        : dtController.Attempted.isEmpty
                            ? Image.asset(
                                "assets/icons/emptyGroup.png",
                                fit: BoxFit.contain,
                              )
                            : SingleChildScrollView(
                                child: ListView.builder(
                                  itemCount: dtController.Attempted.length,
                                  clipBehavior: Clip.hardEdge,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: DuosTestCard(
                                        duosChallenge:
                                            dtController.Attempted[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
                controller: tabController,
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerColumn(),
    );
  }
}
