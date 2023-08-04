class CommunityReport {
  int id;
  String userEmail;
  int communityId;
  DateTime createdAt;

  CommunityReport({
    required this.id,
    required this.userEmail,
    required this.communityId,
    required this.createdAt,
  });

  factory CommunityReport.fromJson(Map<String, Object?> json) => CommunityReport(
    id: json['_id'] as int,
    userEmail: json['userEmail'] as String,
    communityId: json['communityId'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userEmail': userEmail,
    'communityId': communityId,
    'createdAt': createdAt.toIso8601String(),
  };
}
