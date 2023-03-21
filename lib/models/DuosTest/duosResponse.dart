// ignore_for_file: file_names

import 'duosChallenge.dart';

class DuosChallengesResponse {
  String? status;
  String? message;
  List<DuosChallenge>? duosChallenges;
  List<DuosChallenge>? completed;

  DuosChallengesResponse({
    this.status,
    this.message,
    this.duosChallenges,
    this.completed,
  });

  factory DuosChallengesResponse.fromJson(Map<String, dynamic> json) {
    var duosChallengesJson = json['duos_challenges'] as List;
    List<DuosChallenge> duosChallenges =
        duosChallengesJson.map((e) => DuosChallenge.fromJson(e)).toList();

    var completedJson = json['completed'] as List;
    List<DuosChallenge> completed =
        completedJson.map((e) => DuosChallenge.fromJson(e)).toList();

    return DuosChallengesResponse(
      status: json['status'],
      message: json['message'],
      duosChallenges: duosChallenges,
      completed: completed,
    );
  }
}
