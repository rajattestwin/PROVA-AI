import 'questionsClass.dart';

class QuestionOptionsResponse {
  String? status;
  String? message;
  String? duosChallengeId;
  String? challengeTime;
  double? totalMarks;
  List<Questions>? questions;

  QuestionOptionsResponse(
      {this.status,
      this.message,
      this.duosChallengeId,
      this.challengeTime,
      this.totalMarks,
      this.questions});

  QuestionOptionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    duosChallengeId = json['duos_challenge_id'];
    challengeTime = json['challenge_time'];
    totalMarks = json['total_marks'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['duos_challenge_id'] = duosChallengeId;
    data['challenge_time'] = challengeTime;
    data['total_marks'] = totalMarks;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
