class ConsultModel {
  final DateTime date;
  final String hour;
  final String phoneNumber;

  const ConsultModel({
    required this.phoneNumber,
    required this.hour,
    required this.date,
  });

  factory ConsultModel.fromJson(Map<String, Object?> json) => ConsultModel(
        phoneNumber: json['phoneNumber'] as String,
        hour: json['hour'] as String,
        date: DateTime.parse(json['date'] as String),
      );

  toJson() => {
        'phoneNumber': phoneNumber,
        'hour': hour,
        'date': date,
      };

  ConsultModel copyWith({
    String? phoneNumber,
    String? hour,
    DateTime? date,
  }) {
    return ConsultModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hour: hour ?? this.hour,
      date: date ?? this.date,
    );
  }
}
