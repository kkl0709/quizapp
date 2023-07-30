import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_object.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MonthlyAccuracy {
  DateObject? month;
  @Default(0)
  int? totalSolved;
  @Default(0)
  int? totalCorrected;
  MonthlyAccuracy(this.month, this.totalCorrected, this.totalSolved);

  factory MonthlyAccuracy.fromJson(Map<String, dynamic> json) =>
      _$MonthlyAccuracyFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyAccuracyToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class DateObject {
  int? year;
  int? month;
  int? day;
  DateObject(this.year, this.month, this.day);

  factory DateObject.fromJson(Map<String, dynamic> json) =>
      _$DateObjectFromJson(json);
  Map<String, dynamic> toJson() => _$DateObjectToJson(this);
}
