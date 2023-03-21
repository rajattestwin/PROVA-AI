import 'groupChallenge.dart';

class GroupResponse {
  String? status;
  String? message;
  List<GroupChallenges>? groupChallenges;

  GroupResponse({
    this.status,
    this.message,
    this.groupChallenges,
  });

  GroupResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['group_challenges'] != null) {
      groupChallenges = <GroupChallenges>[];
      json['group_challenges'].forEach((v) {
        groupChallenges!.add(GroupChallenges.fromJson(v));
      });
    }
  }
}
