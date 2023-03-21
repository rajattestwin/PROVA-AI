// ignore_for_file: non_constant_identifier_names, file_names

class DuosChallenge {
  String? challengeStatus;
  int? challengeId;
  String? courseLogo;
  String? courseName;
  String? subjectName;
  String? title;
  String? challengerName;
  String? competitorName;
  String? winnerName;
  String? entryAmt;
  String? winningAmt;
  String? winningStatus;
  String? activeTimeLeft;
  String? completedTimestamp;
  String? created_date;

  DuosChallenge({
    this.challengeStatus,
    this.challengeId,
    this.courseLogo,
    this.courseName,
    this.subjectName,
    this.title,
    this.challengerName,
    this.competitorName,
    this.winnerName,
    this.entryAmt,
    this.winningAmt,
    this.winningStatus,
    this.activeTimeLeft,
    this.completedTimestamp,
    this.created_date,
  });

  factory DuosChallenge.fromJson(Map<String, dynamic> json) {
    return DuosChallenge(
      challengeStatus: json['challenge_status'],
      challengeId: json['challenge_id'],
      courseLogo: json['course_logo'],
      courseName: json['course_name'],
      subjectName: json['subject_name'],
      title: json['title'],
      challengerName: json['challenger_name'],
      competitorName: json['competitor_name'],
      winnerName: json['winner_name'],
      entryAmt: json['entry_amt'],
      winningAmt: json['winning_amt'],
      winningStatus: json['winning_status'],
      activeTimeLeft: json['active_time_left'],
      completedTimestamp: json['completed_timestamp'],
      created_date: json['created_date'],
    );
  }
}
