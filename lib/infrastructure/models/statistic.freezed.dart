// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Statistic _$StatisticFromJson(Map<String, dynamic> json) {
  return _Statistic.fromJson(json);
}

/// @nodoc
mixin _$Statistic {
  String? get email => throw _privateConstructorUsedError;
  DateObject? get lastSubmittedAt => throw _privateConstructorUsedError;
  List<DateObject> get dateList => throw _privateConstructorUsedError;
  List<MonthlyAccuracy> get acurracyList => throw _privateConstructorUsedError;
  int? get totalSolved => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatisticCopyWith<Statistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticCopyWith<$Res> {
  factory $StatisticCopyWith(Statistic value, $Res Function(Statistic) then) =
      _$StatisticCopyWithImpl<$Res, Statistic>;
  @useResult
  $Res call(
      {String? email,
      DateObject? lastSubmittedAt,
      List<DateObject> dateList,
      List<MonthlyAccuracy> acurracyList,
      int? totalSolved,
      int? level});
}

/// @nodoc
class _$StatisticCopyWithImpl<$Res, $Val extends Statistic>
    implements $StatisticCopyWith<$Res> {
  _$StatisticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? lastSubmittedAt = freezed,
    Object? dateList = null,
    Object? acurracyList = null,
    Object? totalSolved = freezed,
    Object? level = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSubmittedAt: freezed == lastSubmittedAt
          ? _value.lastSubmittedAt
          : lastSubmittedAt // ignore: cast_nullable_to_non_nullable
              as DateObject?,
      dateList: null == dateList
          ? _value.dateList
          : dateList // ignore: cast_nullable_to_non_nullable
              as List<DateObject>,
      acurracyList: null == acurracyList
          ? _value.acurracyList
          : acurracyList // ignore: cast_nullable_to_non_nullable
              as List<MonthlyAccuracy>,
      totalSolved: freezed == totalSolved
          ? _value.totalSolved
          : totalSolved // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatisticCopyWith<$Res> implements $StatisticCopyWith<$Res> {
  factory _$$_StatisticCopyWith(
          _$_Statistic value, $Res Function(_$_Statistic) then) =
      __$$_StatisticCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      DateObject? lastSubmittedAt,
      List<DateObject> dateList,
      List<MonthlyAccuracy> acurracyList,
      int? totalSolved,
      int? level});
}

/// @nodoc
class __$$_StatisticCopyWithImpl<$Res>
    extends _$StatisticCopyWithImpl<$Res, _$_Statistic>
    implements _$$_StatisticCopyWith<$Res> {
  __$$_StatisticCopyWithImpl(
      _$_Statistic _value, $Res Function(_$_Statistic) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? lastSubmittedAt = freezed,
    Object? dateList = null,
    Object? acurracyList = null,
    Object? totalSolved = freezed,
    Object? level = freezed,
  }) {
    return _then(_$_Statistic(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSubmittedAt: freezed == lastSubmittedAt
          ? _value.lastSubmittedAt
          : lastSubmittedAt // ignore: cast_nullable_to_non_nullable
              as DateObject?,
      dateList: null == dateList
          ? _value._dateList
          : dateList // ignore: cast_nullable_to_non_nullable
              as List<DateObject>,
      acurracyList: null == acurracyList
          ? _value._acurracyList
          : acurracyList // ignore: cast_nullable_to_non_nullable
              as List<MonthlyAccuracy>,
      totalSolved: freezed == totalSolved
          ? _value.totalSolved
          : totalSolved // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Statistic extends _Statistic {
  const _$_Statistic(
      {this.email,
      this.lastSubmittedAt,
      final List<DateObject> dateList = const [],
      final List<MonthlyAccuracy> acurracyList = const [],
      this.totalSolved = 0,
      this.level = 1})
      : _dateList = dateList,
        _acurracyList = acurracyList,
        super._();

  factory _$_Statistic.fromJson(Map<String, dynamic> json) =>
      _$$_StatisticFromJson(json);

  @override
  final String? email;
  @override
  final DateObject? lastSubmittedAt;
  final List<DateObject> _dateList;
  @override
  @JsonKey()
  List<DateObject> get dateList {
    if (_dateList is EqualUnmodifiableListView) return _dateList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dateList);
  }

  final List<MonthlyAccuracy> _acurracyList;
  @override
  @JsonKey()
  List<MonthlyAccuracy> get acurracyList {
    if (_acurracyList is EqualUnmodifiableListView) return _acurracyList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_acurracyList);
  }

  @override
  @JsonKey()
  final int? totalSolved;
  @override
  @JsonKey()
  final int? level;

  @override
  String toString() {
    return 'Statistic(email: $email, lastSubmittedAt: $lastSubmittedAt, dateList: $dateList, acurracyList: $acurracyList, totalSolved: $totalSolved, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Statistic &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.lastSubmittedAt, lastSubmittedAt) ||
                other.lastSubmittedAt == lastSubmittedAt) &&
            const DeepCollectionEquality().equals(other._dateList, _dateList) &&
            const DeepCollectionEquality()
                .equals(other._acurracyList, _acurracyList) &&
            (identical(other.totalSolved, totalSolved) ||
                other.totalSolved == totalSolved) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      lastSubmittedAt,
      const DeepCollectionEquality().hash(_dateList),
      const DeepCollectionEquality().hash(_acurracyList),
      totalSolved,
      level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatisticCopyWith<_$_Statistic> get copyWith =>
      __$$_StatisticCopyWithImpl<_$_Statistic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatisticToJson(
      this,
    );
  }
}

abstract class _Statistic extends Statistic {
  const factory _Statistic(
      {final String? email,
      final DateObject? lastSubmittedAt,
      final List<DateObject> dateList,
      final List<MonthlyAccuracy> acurracyList,
      final int? totalSolved,
      final int? level}) = _$_Statistic;
  const _Statistic._() : super._();

  factory _Statistic.fromJson(Map<String, dynamic> json) =
      _$_Statistic.fromJson;

  @override
  String? get email;
  @override
  DateObject? get lastSubmittedAt;
  @override
  List<DateObject> get dateList;
  @override
  List<MonthlyAccuracy> get acurracyList;
  @override
  int? get totalSolved;
  @override
  int? get level;
  @override
  @JsonKey(ignore: true)
  _$$_StatisticCopyWith<_$_Statistic> get copyWith =>
      throw _privateConstructorUsedError;
}
