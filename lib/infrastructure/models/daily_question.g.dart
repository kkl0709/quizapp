// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyQuestion _$$_DailyQuestionFromJson(Map<String, dynamic> json) =>
    _$_DailyQuestion(
      date: json['date'] == null
          ? null
          : DateObject.fromJson(json['date'] as Map<String, dynamic>),
      question: json['question'] as String?,
      answer: json['answer'] as int?,
    );

Map<String, dynamic> _$$_DailyQuestionToJson(_$_DailyQuestion instance) =>
    <String, dynamic>{
      'date': instance.date,
      'question': instance.question,
      'answer': instance.answer,
    };
