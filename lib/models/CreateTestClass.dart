// ignore_for_file: file_names

class CreateTestClass {
  String? chapterId;
  int? entryAmount;
  String? type;
  int? slots;
  String? startTime;

  CreateTestClass({
    this.chapterId,
    this.entryAmount,
    this.type,
    this.slots,
    this.startTime,
  });

  CreateTestClass.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    entryAmount = json['entry_amt'];
    type = json['challenge_type'];
    slots = json['slots'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_id'] = chapterId;
    data['entry_amt'] = entryAmount;
    data['challenge_type'] = type;
    data['slots'] = slots;
    data['start_time'] = startTime;
    return data;
  }
}
