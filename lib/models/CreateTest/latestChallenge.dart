import 'package:provaai/models/DuosTest/duosChallenge.dart';

class LatestDuosChallengeResponse {
  String? status;
  String? message;
  String? challengetype;
  List<DuosChallenge?>? latestduoschallenge;

  LatestDuosChallengeResponse({
    this.status,
    this.message,
    this.challengetype,
    this.latestduoschallenge,
  });

  LatestDuosChallengeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    challengetype = json['challenge_type'];
    if (json['latest_duos_challenge'] != null) {
      latestduoschallenge = <DuosChallenge>[];
      json['latest_duos_challenge'].forEach((v) {
        latestduoschallenge!.add(DuosChallenge.fromJson(v));
      });
    }
  }
}
