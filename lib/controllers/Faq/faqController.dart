import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provaai/models/Faq/faqModel.dart';
import 'package:provaai/utils/apiEndpoints.dart';

class FaqController extends GetxController {
  var faqs = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getFaqs();
    super.onInit();
  }

  getFaqs() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.faqSection),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var faqsList = FaqModel.fromJson(json).faqdetails!.toList();
        faqs.addAll(faqsList);
      } else {}
    } catch (e) {
      log("Failed Fetching Faqs");
    } finally {
      isLoading(false);
    }
  }

  createSupportTicket() async {}
}
