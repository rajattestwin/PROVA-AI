/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class History {
  String? amounttransacted;
  String? transactionstatus;
  String? description;
  String? time;

  History(
      {this.amounttransacted,
      this.transactionstatus,
      this.description,
      this.time});

  History.fromJson(Map<String, dynamic> json) {
    amounttransacted = json['amount_transacted'];
    transactionstatus = json['transaction_status'];
    description = json['description'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount_transacted'] = amounttransacted;
    data['transaction_status'] = transactionstatus;
    data['description'] = description;
    data['time'] = time;
    return data;
  }
}

class WalletHistoryReponse {
  String? status;
  String? message;
  String? studentname;
  List<WalletHistory?>? wallethistory;

  WalletHistoryReponse(
      {this.status, this.message, this.studentname, this.wallethistory});

  WalletHistoryReponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    studentname = json['student_name'];
    if (json['wallet_history'] != null) {
      wallethistory = <WalletHistory>[];
      json['wallet_history'].forEach((v) {
        wallethistory!.add(WalletHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['student_name'] = studentname;
    data['wallet_history'] = wallethistory != null
        ? wallethistory!.map((v) => v?.toJson()).toList()
        : null;
    return data;
  }
}

class WalletHistory {
  String? date;
  List<History?>? history;

  WalletHistory({this.date, this.history});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['history'] =
        history != null ? history!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
