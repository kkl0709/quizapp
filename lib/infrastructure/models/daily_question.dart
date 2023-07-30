import 'package:chinesequizapp/infrastructure/models/date_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'daily_question.freezed.dart';
part 'daily_question.g.dart';

@freezed
class DailyQuestion with _$DailyQuestion {
  const DailyQuestion._();
  const factory DailyQuestion({
    DateObject? date,
    String? question,
    int? answer, // 0 : 정답, 1 : 오답
  }) = _DailyQuestion;

  factory DailyQuestion.fromJson(Map<String, Object?> json) =>
      _$DailyQuestionFromJson(json);
}
