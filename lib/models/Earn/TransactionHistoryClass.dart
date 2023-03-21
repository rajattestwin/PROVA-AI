class TransactionHistoryClass {
  String? amountcredited;
  String? transactionstatus;
  String? description;
  String? date;
  String? time;
  String? dateandtime;

  TransactionHistoryClass({
    this.amountcredited,
    this.transactionstatus,
    this.description,
    this.date,
    this.time,
    this.dateandtime,
  });

  TransactionHistoryClass.fromJson(Map<String, dynamic> json) {
    amountcredited = json['amount_credited'];
    transactionstatus = json['transaction_status'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    dateandtime = json['date_and_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['amount_credited'] = amountcredited;
    data['transaction_status'] = transactionstatus;
    data['description'] = description;
    data['date'] = date;
    data['time'] = time;
    data['date_and_time'] = dateandtime;
    return data;
  }
}
