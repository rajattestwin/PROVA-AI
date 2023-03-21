class Options {
  int? id;
  String? optionText;
  String? optionImg;

  Options({this.id, this.optionText, this.optionImg});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionText = json['optionText'];
    optionImg = json['optionImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['optionText'] = optionText;
    data['optionImg'] = optionImg;
    return data;
  }
}
