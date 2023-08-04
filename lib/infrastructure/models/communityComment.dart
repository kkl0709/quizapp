import 'package:chinesequizapp/infrastructure/models/account.dart';

class CommunityComment {
  int id;
  int communityId;
  int userAuthType;
  String userEmail;
  String contents;
  DateTime createdAt;

  Account? account;

  CommunityComment({
    required this.id,
    required this.communityId,
    required this.userAuthType,
    required this.userEmail,
    required this.contents,
    required this.createdAt,
  });

  factory CommunityComment.fromJson(Map<String, Object?> json) => CommunityComment(
    id: json['_id'] as int,
    communityId: json['communityId'] as int,
    userAuthType: json['userAuthType'] as int,
    userEmail: json['userEmail'] as String,
    contents: json['contents'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'communityId': communityId,
    'userAuthType': userAuthType,
    'userEmail': userEmail,
    'contents': contents,
    'createdAt': createdAt.toIso8601String(),
  };
}
