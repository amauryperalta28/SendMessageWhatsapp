// To parse this JSON data, do
//
//     final groupMember = groupMemberFromJson(jsonString);

import 'dart:convert';

GroupMember groupMemberFromJson(String str) =>
    GroupMember.fromJson(json.decode(str));

String groupMemberToJson(GroupMember data) => json.encode(data.toJson());

class GroupMember {
  GroupMember({
    this.groupName,
    this.memberName,
    this.memberNumber,
  });

  String groupName;
  String memberName;
  String memberNumber;
  bool messageSent;

  factory GroupMember.fromJson(Map<String, dynamic> json) => GroupMember(
        groupName: json["groupName"],
        memberName: json["memberName"],
        memberNumber: json["memberNumber"],
      );

  Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "memberName": memberName,
        "memberNumber": memberNumber,
      };
}
