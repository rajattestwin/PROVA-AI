// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:provaai/controllers/User/userController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
    //Get.lazyPut(() => GiveTestController());
  }
}
