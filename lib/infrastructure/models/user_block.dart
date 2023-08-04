class UserBlock {
  int id;
  String userEmail;
  String targetUserEmail;
  DateTime createdAt;

  UserBlock({
    required this.id,
    required this.userEmail,
    required this.targetUserEmail,
    required this.createdAt,
  });

  factory UserBlock.fromJson(Map<String, Object?> json) => UserBlock(
    id: json['_id'] as int,
    userEmail: json['userEmail'] as String,
    targetUserEmail: json['targetUserEmail'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userEmail': userEmail,
    'targetUserEmail': targetUserEmail,
    'createdAt': createdAt.toIso8601String(),
  };
}
