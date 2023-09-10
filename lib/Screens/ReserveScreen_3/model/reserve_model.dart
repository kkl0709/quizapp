import 'package:cloud_firestore/cloud_firestore.dart';

class ReserveModel {
  final String userEmail;
  final Timestamp date;
  final String status;
  final List<dynamic> noReserveDate;
  final String phoneNumber;

  const ReserveModel({
    required this.date,
    required this.userEmail,
    required this.status,
    required this.noReserveDate,
    required this.phoneNumber,
  });

  toJson() {
    return {
      'userEmail': userEmail,
      'date': date,
      'status': status,
      'noReserveDate': noReserveDate,
      'phoneNumber': phoneNumber,
    };
  }

  factory ReserveModel.fromJson(Map<String, dynamic> json) {
    return ReserveModel(
      userEmail: json['userEmail'] as String,
      date: json['date'] as Timestamp,
      status: json['status'] as String,
      noReserveDate: json['noReserveDate'] as List<dynamic>,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  ReserveModel copyWith(
      {String? userEmail,
      Timestamp? date,
      String? status,
      List<dynamic>? noReserveDate,
      String? phoneNumber}) {
    return ReserveModel(
      userEmail: userEmail ?? this.userEmail,
      date: date ?? this.date,
      status: status ?? this.status,
      noReserveDate: noReserveDate ?? this.noReserveDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
