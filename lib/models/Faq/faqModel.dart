class FaqDetail {
  String? title;
  String? description;

  FaqDetail({this.title, this.description});

  FaqDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class FaqModel {
  String? status;
  String? message;
  List<FaqDetail?>? faqdetails;

  FaqModel({this.status, this.message, this.faqdetails});

  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['faq_details'] != null) {
      faqdetails = <FaqDetail>[];
      json['faq_details'].forEach((v) {
        faqdetails!.add(FaqDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['faq_details'] = faqdetails != null
        ? faqdetails!.map((v) => v?.toJson()).toList()
        : null;
    return data;
  }
}
