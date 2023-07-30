// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'database_resp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DatabaseResp _$DatabaseRespFromJson(Map<String, dynamic> json) {
  return _DatabaseResp.fromJson(json);
}

/// @nodoc
mixin _$DatabaseResp {
  dynamic get data => throw _privateConstructorUsedError;
  bool? get isException => throw _privateConstructorUsedError;
  DbRespError? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatabaseRespCopyWith<DatabaseResp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseRespCopyWith<$Res> {
  factory $DatabaseRespCopyWith(
          DatabaseResp value, $Res Function(DatabaseResp) then) =
      _$DatabaseRespCopyWithImpl<$Res, DatabaseResp>;
  @useResult
  $Res call({dynamic data, bool? isException, DbRespError? error});
}

/// @nodoc
class _$DatabaseRespCopyWithImpl<$Res, $Val extends DatabaseResp>
    implements $DatabaseRespCopyWith<$Res> {
  _$DatabaseRespCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isException = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isException: freezed == isException
          ? _value.isException
          : isException // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as DbRespError?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DatabaseRespCopyWith<$Res>
    implements $DatabaseRespCopyWith<$Res> {
  factory _$$_DatabaseRespCopyWith(
          _$_DatabaseResp value, $Res Function(_$_DatabaseResp) then) =
      __$$_DatabaseRespCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic data, bool? isException, DbRespError? error});
}

/// @nodoc
class __$$_DatabaseRespCopyWithImpl<$Res>
    extends _$DatabaseRespCopyWithImpl<$Res, _$_DatabaseResp>
    implements _$$_DatabaseRespCopyWith<$Res> {
  __$$_DatabaseRespCopyWithImpl(
      _$_DatabaseResp _value, $Res Function(_$_DatabaseResp) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isException = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_DatabaseResp(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isException: freezed == isException
          ? _value.isException
          : isException // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as DbRespError?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DatabaseResp extends _DatabaseResp {
  const _$_DatabaseResp({this.data, this.isException, this.error}) : super._();

  factory _$_DatabaseResp.fromJson(Map<String, dynamic> json) =>
      _$$_DatabaseRespFromJson(json);

  @override
  final dynamic data;
  @override
  final bool? isException;
  @override
  final DbRespError? error;

  @override
  String toString() {
    return 'DatabaseResp(data: $data, isException: $isException, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DatabaseResp &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.isException, isException) ||
                other.isException == isException) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), isException, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DatabaseRespCopyWith<_$_DatabaseResp> get copyWith =>
      __$$_DatabaseRespCopyWithImpl<_$_DatabaseResp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DatabaseRespToJson(
      this,
    );
  }
}

abstract class _DatabaseResp extends DatabaseResp {
  const factory _DatabaseResp(
      {final dynamic data,
      final bool? isException,
      final DbRespError? error}) = _$_DatabaseResp;
  const _DatabaseResp._() : super._();

  factory _DatabaseResp.fromJson(Map<String, dynamic> json) =
      _$_DatabaseResp.fromJson;

  @override
  dynamic get data;
  @override
  bool? get isException;
  @override
  DbRespError? get error;
  @override
  @JsonKey(ignore: true)
  _$$_DatabaseRespCopyWith<_$_DatabaseResp> get copyWith =>
      throw _privateConstructorUsedError;
}
