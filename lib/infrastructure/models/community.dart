class Community {
  int id;
  int userAuthType;
  String userEmail;
  String? imgUrl;
  String contents;
  DateTime createdAt;

  Community({
    required this.id,
    required this.userAuthType,
    required this.userEmail,
    this.imgUrl,
    required this.contents,
    required this.createdAt,
  });

  factory Community.fromJson(Map<String, Object?> json) => Community(
    id: json['_id'] as int,
    userAuthType: json['userAuthType'] as int,
    userEmail: json['userEmail'] as String,
    imgUrl: json['imgUrl'] as String?,
    contents: json['contents'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userAuthType': userAuthType,
    'userEmail': userEmail,
    'imgUrl': imgUrl,
    'contents': contents,
    'createdAt': createdAt.toIso8601String(),
  };
}
