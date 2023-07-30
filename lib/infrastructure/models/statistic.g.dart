// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Statistic _$$_StatisticFromJson(Map<String, dynamic> json) => _$_Statistic(
      email: json['email'] as String?,
      lastSubmittedAt: json['lastSubmittedAt'] == null
          ? null
          : DateObject.fromJson(
              json['lastSubmittedAt'] as Map<String, dynamic>),
      dateList: (json['dateList'] as List<dynamic>?)
              ?.map((e) => DateObject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      acurracyList: (json['acurracyList'] as List<dynamic>?)
              ?.map((e) => MonthlyAccuracy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalSolved: json['totalSolved'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
    );

Map<String, dynamic> _$$_StatisticToJson(_$_Statistic instance) =>
    <String, dynamic>{
      'email': instance.email,
      'lastSubmittedAt': instance.lastSubmittedAt?.toJson(),
      'dateList': instance.dateList.map((e) => e.toJson()).toList(),
      'acurracyList': instance.acurracyList.map((e) => e.toJson()).toList(),
      'totalSolved': instance.totalSolved,
      'level': instance.level,
    };
