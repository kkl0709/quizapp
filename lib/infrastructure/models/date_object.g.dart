// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyAccuracy _$MonthlyAccuracyFromJson(Map<String, dynamic> json) =>
    MonthlyAccuracy(
      json['month'] == null
          ? null
          : DateObject.fromJson(json['month'] as Map<String, dynamic>),
      json['total_corrected'] as int?,
      json['total_solved'] as int?,
    );

Map<String, dynamic> _$MonthlyAccuracyToJson(MonthlyAccuracy instance) =>
    <String, dynamic>{
      'month': instance.month?.toJson(),
      'total_solved': instance.totalSolved,
      'total_corrected': instance.totalCorrected,
    };

DateObject _$DateObjectFromJson(Map<String, dynamic> json) => DateObject(
      json['year'] as int?,
      json['month'] as int?,
      json['day'] as int?,
    );

Map<String, dynamic> _$DateObjectToJson(DateObject instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
    };
