// ignore_for_file: file_names

class TestAnalyticsClass {
  String? status;
  String? message;
  String? studentName;
  int? rank;
  String? winningStatus;
  String? winningMessage;
  String? rewardWon;
  double? marksScored;
  double? totalMarks;
  int? noOfQuesAttempted;
  int? totalNoOfQues;
  String? totalAttemptDuration;
  String? totalChallengeDuration;
  int? noOfCorrectQues;
  int? noOfWrongQues;
  int? noOfSkippedQues;
  String? completionPercent;
  List<QuestionsDetail>? questionsDetail;
  List<Leaderboard>? leaderboard;
  int? first_time;

  TestAnalyticsClass(
      {this.status,
      this.message,
      this.studentName,
      this.rank,
      this.winningStatus,
      this.winningMessage,
      this.rewardWon,
      this.marksScored,
      this.totalMarks,
      this.noOfQuesAttempted,
      this.totalNoOfQues,
      this.totalAttemptDuration,
      this.totalChallengeDuration,
      this.noOfCorrectQues,
      this.noOfWrongQues,
      this.noOfSkippedQues,
      this.completionPercent,
      this.questionsDetail,
      this.leaderboard,
      this.first_time});

  TestAnalyticsClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    studentName = json['student_name'];
    rank = json['rank'];
    winningStatus = json['winning_status'];
    winningMessage = json['winning_message'];
    rewardWon = json['reward_won'];
    marksScored = json['marks_scored'];
    totalMarks = json['total_marks'];
    noOfQuesAttempted = json['no_of_ques_attempted'];
    totalNoOfQues = json['total_no_of_ques'];
    totalAttemptDuration = json['total_attempt_duration'];
    totalChallengeDuration = json['total_challenge_duration'];
    noOfCorrectQues = json['no_of_correct_ques'];
    noOfWrongQues = json['no_of_wrong_ques'];
    noOfSkippedQues = json['no_of_skipped_ques'];
    completionPercent = json['completion_percent'];
    if (json['questions_detail'] != null) {
      questionsDetail = <QuestionsDetail>[];
      json['questions_detail'].forEach((v) {
        questionsDetail!.add(QuestionsDetail.fromJson(v));
      });
    }
    if (json['leaderboard'] != null) {
      leaderboard = <Leaderboard>[];
      json['leaderboard'].forEach((v) {
        leaderboard!.add(Leaderboard.fromJson(v));
      });
    }
    first_time = json['first_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['student_name'] = studentName;
    data['rank'] = rank;
    data['winning_status'] = winningStatus;
    data['winning_message'] = winningMessage;
    data['reward_won'] = rewardWon;
    data['marks_scored'] = marksScored;
    data['total_marks'] = totalMarks;
    data['no_of_ques_attempted'] = noOfQuesAttempted;
    data['total_no_of_ques'] = totalNoOfQues;
    data['total_attempt_duration'] = totalAttemptDuration;
    data['total_challenge_duration'] = totalChallengeDuration;
    data['no_of_correct_ques'] = noOfCorrectQues;
    data['no_of_wrong_ques'] = noOfWrongQues;
    data['no_of_skipped_ques'] = noOfSkippedQues;
    data['completion_percent'] = completionPercent;
    if (questionsDetail != null) {
      data['questions_detail'] =
          questionsDetail!.map((v) => v.toJson()).toList();
    }
    if (leaderboard != null) {
      data['leaderboard'] = leaderboard!.map((v) => v.toJson()).toList();
    }
    data['first_time'] = first_time;
    return data;
  }
}

class QuestionsDetail {
  String? question;
  String? opt1;
  String? opt2;
  String? opt3;
  String? opt4;
  String? selectedOption;
  String? correctOption;
  String? attemptDuration;

  QuestionsDetail(
      {this.question,
      this.opt1,
      this.opt2,
      this.opt3,
      this.opt4,
      this.selectedOption,
      this.correctOption,
      this.attemptDuration});

  QuestionsDetail.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    opt1 = json['opt1'];
    opt2 = json['opt2'];
    opt3 = json['opt3'];
    opt4 = json['opt4'];
    selectedOption = json['selected_option'];
    correctOption = json['correct_option'];
    attemptDuration = json['attempt_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['opt1'] = this.opt1;
    data['opt2'] = this.opt2;
    data['opt3'] = this.opt3;
    data['opt4'] = this.opt4;
    data['selected_option'] = this.selectedOption;
    data['correct_option'] = this.correctOption;
    data['attempt_duration'] = this.attemptDuration;
    return data;
  }
}

class Leaderboard {
  String? studentAvatar;
  String? studentName;
  int? gcRank;

  Leaderboard({this.studentAvatar, this.studentName, this.gcRank});

  Leaderboard.fromJson(Map<String, dynamic> json) {
    studentAvatar = json['student__avatar'];
    studentName = json['student__name'];
    gcRank = json['gcRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student__avatar'] = studentAvatar;
    data['student__name'] = studentName;
    data['gcRank'] = gcRank;
    return data;
  }
}
