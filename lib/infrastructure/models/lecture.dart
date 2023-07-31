class Lecture {
  int id;
  String imgUrl;
  String videoUrl;
  int number;
  String title;
  int price;
  DateTime createdAt;

  Lecture({
    required this.id,
    required this.imgUrl,
    required this.videoUrl,
    required this.number,
    required this.title,
    required this.price,
    required this.createdAt,
  });

  factory Lecture.fromJson(Map<String, Object?> json) => Lecture(
    id: json['_id'] as int,
    imgUrl: json['imgUrl'] as String,
    videoUrl: json['videoUrl'] as String,
    number: json['number'] as int,
    title: json['title'] as String,
    price: json['price'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'imgUrl': imgUrl,
    'videoUrl': videoUrl,
    'number': number,
    'title': title,
    'price': price,
    'createdAt': createdAt.toIso8601String(),
  };
}
