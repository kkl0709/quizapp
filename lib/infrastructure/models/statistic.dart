import 'package:chinesequizapp/infrastructure/models/date_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'statistic.freezed.dart';
part 'statistic.g.dart';

@freezed
class Statistic with _$Statistic {
  const Statistic._();
  @JsonSerializable(explicitToJson: true)
  const factory Statistic({
    String? email,
    DateObject? lastSubmittedAt,
    @Default([]) List<DateObject> dateList,
    @Default([]) List<MonthlyAccuracy> acurracyList,
    @Default(0) int? totalSolved,
    @Default(1) int? level,
  }) = _Statistic;

  factory Statistic.init(String email) => Statistic(
        email: email,
        totalSolved: 0,
        level: 1,
      );

  static const empty = Statistic();

  factory Statistic.fromJson(Map<String, Object?> json) =>
      _$StatisticFromJson(json);
}
