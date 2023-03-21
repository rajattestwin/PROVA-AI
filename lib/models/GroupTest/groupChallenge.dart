class GroupChallenges {
  String? challengeStatus;
  int? challengeId;
  String? courseLogo;
  String? courseName;
  String? subjectName;
  String? title;
  String? challengerName;
  int? slots;
  int? remainingSlots;
  List<dynamic>? challengeParticipants;
  int? challengeRank;
  String? challenge1stWinner;
  String? entryAmt;
  List<dynamic>? challengeRewards;
  String? rewardWon;
  String? createdDate;
  String? startTimeLeft;
  String? completedTimestamp;
  String? winningAmtUpto;

  GroupChallenges(
      {this.challengeStatus,
      this.challengeId,
      this.courseLogo,
      this.courseName,
      this.subjectName,
      this.title,
      this.challengerName,
      this.slots,
      this.remainingSlots,
      this.challengeParticipants,
      this.challengeRank,
      this.challenge1stWinner,
      this.entryAmt,
      this.challengeRewards,
      this.rewardWon,
      this.createdDate,
      this.startTimeLeft,
      this.completedTimestamp,
      this.winningAmtUpto});

  GroupChallenges.fromJson(Map<String, dynamic> json) {
    challengeStatus = json['challenge_status'];
    challengeId = json['challenge_id'];
    courseLogo = json['course_logo'];
    courseName = json['course_name'];
    subjectName = json['subject_name'];
    title = json['title'];
    challengerName = json['challenger_name'];
    slots = json['slots'];
    remainingSlots = json['remaining_slots'];
    challengeParticipants = json['challenge_participants'];
    challengeRank = json['challenge_rank'];
    challenge1stWinner = json['challenge_1st_winner'];
    entryAmt = json['entry_amt'];
    challengeRewards = json['challenge_rewards'];
    rewardWon = json['reward_won'];
    createdDate = json['created_date'];
    startTimeLeft = json['start_time_left'];
    completedTimestamp = json['completed_timestamp'];
    winningAmtUpto = json['winning_amt_upto'];
  }
}
