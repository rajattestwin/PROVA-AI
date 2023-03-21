// ignore_for_file: file_names

class WalletBalance {
  String? status;
  String? message;
  String? studentname;
  int? walletbalance;
  int? addedamt;
  int? rewardamt;
  int? bonuswalletbalance;

  WalletBalance({
    this.status,
    this.message,
    this.studentname,
    this.walletbalance,
    this.addedamt,
    this.rewardamt,
    this.bonuswalletbalance,
  });

  WalletBalance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    studentname = json['student_name'];
    walletbalance = json['wallet_balance'];
    addedamt = json['added_amt'];
    rewardamt = json['reward_amt'];
    bonuswalletbalance = json['bonus_wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['student_name'] = studentname;
    data['wallet_balance'] = walletbalance;
    data['added_amt'] = addedamt;
    data['reward_amt'] = rewardamt;
    data['bonus_wallet_balance'] = bonuswalletbalance;
    return data;
  }
}
