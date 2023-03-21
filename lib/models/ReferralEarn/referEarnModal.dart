class ReferEarn {
  String? status;
  String? message;
  String? studentname;
  String? referralcode;
  String? referralurl;
  String? totalreferralamt;

  ReferEarn(
      {this.status,
      this.message,
      this.studentname,
      this.referralcode,
      this.referralurl,
      this.totalreferralamt});

  ReferEarn.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    studentname = json['student_name'];
    referralcode = json['referral_code'];
    referralurl = json['referral_url'];
    totalreferralamt = json['total_referral_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['student_name'] = studentname;
    data['referral_code'] = referralcode;
    data['referral_url'] = referralurl;
    data['total_referral_amt'] = totalreferralamt;
    return data;
  }
}
