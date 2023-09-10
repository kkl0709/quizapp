class ConsultModel {
  final DateTime date;
  final String phoneNumber;

  const ConsultModel({
    required this.phoneNumber,
    required this.date,
  });

  factory ConsultModel.fromJson(Map<String, Object?> json) => ConsultModel(
        phoneNumber: json['phoneNumber'] as String,
        date: DateTime.parse(json['date'] as String),
      );

  toJson() => {
        'phoneNumber': phoneNumber,
        'date': date,
      };

  ConsultModel copyWith({
    String? phoneNumber,
    String? hour,
    DateTime? date,
  }) {
    return ConsultModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      date: date ?? this.date,
    );
  }
}
