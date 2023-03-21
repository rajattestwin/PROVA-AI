/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class BonusAmtWalletHistory {
  String? date;
  List<History?>? history;

  BonusAmtWalletHistory({this.date, this.history});

  BonusAmtWalletHistory.fromJson(Map<String, dynamic> json) {
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

class BonusAmtWalletHistoryResponse {
  String? status;
  String? message;
  String? studentname;
  List<BonusAmtWalletHistory?>? bonusamtwallethistory;

  BonusAmtWalletHistoryResponse(
      {this.status,
      this.message,
      this.studentname,
      this.bonusamtwallethistory});

  BonusAmtWalletHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    studentname = json['student_name'];
    if (json['bonus_amt_wallet_history'] != null) {
      bonusamtwallethistory = <BonusAmtWalletHistory>[];
      json['bonus_amt_wallet_history'].forEach((v) {
        bonusamtwallethistory!.add(BonusAmtWalletHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['student_name'] = studentname;
    data['bonus_amt_wallet_history'] = bonusamtwallethistory != null
        ? bonusamtwallethistory!.map((v) => v?.toJson()).toList()
        : null;
    return data;
  }
}
