// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyQuestion _$DailyQuestionFromJson(Map<String, dynamic> json) {
  return _DailyQuestion.fromJson(json);
}

/// @nodoc
mixin _$DailyQuestion {
  DateObject? get date => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  int? get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyQuestionCopyWith<DailyQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyQuestionCopyWith<$Res> {
  factory $DailyQuestionCopyWith(
          DailyQuestion value, $Res Function(DailyQuestion) then) =
      _$DailyQuestionCopyWithImpl<$Res, DailyQuestion>;
  @useResult
  $Res call({DateObject? date, String? question, int? answer});
}

/// @nodoc
class _$DailyQuestionCopyWithImpl<$Res, $Val extends DailyQuestion>
    implements $DailyQuestionCopyWith<$Res> {
  _$DailyQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? question = freezed,
    Object? answer = freezed,
  }) {
    return _then(_value.copyWith(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateObject?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyQuestionCopyWith<$Res>
    implements $DailyQuestionCopyWith<$Res> {
  factory _$$_DailyQuestionCopyWith(
          _$_DailyQuestion value, $Res Function(_$_DailyQuestion) then) =
      __$$_DailyQuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateObject? date, String? question, int? answer});
}

/// @nodoc
class __$$_DailyQuestionCopyWithImpl<$Res>
    extends _$DailyQuestionCopyWithImpl<$Res, _$_DailyQuestion>
    implements _$$_DailyQuestionCopyWith<$Res> {
  __$$_DailyQuestionCopyWithImpl(
      _$_DailyQuestion _value, $Res Function(_$_DailyQuestion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? question = freezed,
    Object? answer = freezed,
  }) {
    return _then(_$_DailyQuestion(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateObject?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DailyQuestion extends _DailyQuestion {
  const _$_DailyQuestion({this.date, this.question, this.answer}) : super._();

  factory _$_DailyQuestion.fromJson(Map<String, dynamic> json) =>
      _$$_DailyQuestionFromJson(json);

  @override
  final DateObject? date;
  @override
  final String? question;
  @override
  final int? answer;

  @override
  String toString() {
    return 'DailyQuestion(date: $date, question: $question, answer: $answer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyQuestion &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, question, answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyQuestionCopyWith<_$_DailyQuestion> get copyWith =>
      __$$_DailyQuestionCopyWithImpl<_$_DailyQuestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyQuestionToJson(
      this,
    );
  }
}

abstract class _DailyQuestion extends DailyQuestion {
  const factory _DailyQuestion(
      {final DateObject? date,
      final String? question,
      final int? answer}) = _$_DailyQuestion;
  const _DailyQuestion._() : super._();

  factory _DailyQuestion.fromJson(Map<String, dynamic> json) =
      _$_DailyQuestion.fromJson;

  @override
  DateObject? get date;
  @override
  String? get question;
  @override
  int? get answer;
  @override
  @JsonKey(ignore: true)
  _$$_DailyQuestionCopyWith<_$_DailyQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}
