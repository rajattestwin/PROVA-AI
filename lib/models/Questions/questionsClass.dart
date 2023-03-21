import 'optionsClass.dart';

class Questions {
  int? quesId;
  String? quesText;
  String? quesImg;
  String? quesTime;
  List<Options>? options;

  Questions(
      {this.quesId, this.quesText, this.quesImg, this.quesTime, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    quesId = json['ques_id'];
    quesText = json['ques_text'];
    quesImg = json['ques_img'];
    quesTime = json['ques_time'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ques_id'] = quesId;
    data['ques_text'] = quesText;
    data['ques_img'] = quesImg;
    data['ques_time'] = quesTime;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
