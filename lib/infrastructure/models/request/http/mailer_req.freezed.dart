// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mailer_req.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MailerSendReq _$MailerSendReqFromJson(Map<String, dynamic> json) {
  return _MailerSendReq.fromJson(json);
}

/// @nodoc
mixin _$MailerSendReq {
  String? get senderAddress => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  List<Recipient>? get recipients => throw _privateConstructorUsedError;
  bool? get individual => throw _privateConstructorUsedError;
  bool? get advertising => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MailerSendReqCopyWith<MailerSendReq> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailerSendReqCopyWith<$Res> {
  factory $MailerSendReqCopyWith(
          MailerSendReq value, $Res Function(MailerSendReq) then) =
      _$MailerSendReqCopyWithImpl<$Res, MailerSendReq>;
  @useResult
  $Res call(
      {String? senderAddress,
      String? title,
      String? body,
      List<Recipient>? recipients,
      bool? individual,
      bool? advertising});
}

/// @nodoc
class _$MailerSendReqCopyWithImpl<$Res, $Val extends MailerSendReq>
    implements $MailerSendReqCopyWith<$Res> {
  _$MailerSendReqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAddress = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? recipients = freezed,
    Object? individual = freezed,
    Object? advertising = freezed,
  }) {
    return _then(_value.copyWith(
      senderAddress: freezed == senderAddress
          ? _value.senderAddress
          : senderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      recipients: freezed == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Recipient>?,
      individual: freezed == individual
          ? _value.individual
          : individual // ignore: cast_nullable_to_non_nullable
              as bool?,
      advertising: freezed == advertising
          ? _value.advertising
          : advertising // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MailerSendReqCopyWith<$Res>
    implements $MailerSendReqCopyWith<$Res> {
  factory _$$_MailerSendReqCopyWith(
          _$_MailerSendReq value, $Res Function(_$_MailerSendReq) then) =
      __$$_MailerSendReqCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? senderAddress,
      String? title,
      String? body,
      List<Recipient>? recipients,
      bool? individual,
      bool? advertising});
}

/// @nodoc
class __$$_MailerSendReqCopyWithImpl<$Res>
    extends _$MailerSendReqCopyWithImpl<$Res, _$_MailerSendReq>
    implements _$$_MailerSendReqCopyWith<$Res> {
  __$$_MailerSendReqCopyWithImpl(
      _$_MailerSendReq _value, $Res Function(_$_MailerSendReq) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAddress = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? recipients = freezed,
    Object? individual = freezed,
    Object? advertising = freezed,
  }) {
    return _then(_$_MailerSendReq(
      senderAddress: freezed == senderAddress
          ? _value.senderAddress
          : senderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      recipients: freezed == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Recipient>?,
      individual: freezed == individual
          ? _value.individual
          : individual // ignore: cast_nullable_to_non_nullable
              as bool?,
      advertising: freezed == advertising
          ? _value.advertising
          : advertising // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MailerSendReq extends _MailerSendReq {
  const _$_MailerSendReq(
      {this.senderAddress,
      this.title,
      this.body,
      final List<Recipient>? recipients,
      this.individual,
      this.advertising})
      : _recipients = recipients,
        super._();

  factory _$_MailerSendReq.fromJson(Map<String, dynamic> json) =>
      _$$_MailerSendReqFromJson(json);

  @override
  final String? senderAddress;
  @override
  final String? title;
  @override
  final String? body;
  final List<Recipient>? _recipients;
  @override
  List<Recipient>? get recipients {
    final value = _recipients;
    if (value == null) return null;
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? individual;
  @override
  final bool? advertising;

  @override
  String toString() {
    return 'MailerSendReq(senderAddress: $senderAddress, title: $title, body: $body, recipients: $recipients, individual: $individual, advertising: $advertising)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MailerSendReq &&
            (identical(other.senderAddress, senderAddress) ||
                other.senderAddress == senderAddress) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients) &&
            (identical(other.individual, individual) ||
                other.individual == individual) &&
            (identical(other.advertising, advertising) ||
                other.advertising == advertising));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderAddress,
      title,
      body,
      const DeepCollectionEquality().hash(_recipients),
      individual,
      advertising);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MailerSendReqCopyWith<_$_MailerSendReq> get copyWith =>
      __$$_MailerSendReqCopyWithImpl<_$_MailerSendReq>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MailerSendReqToJson(
      this,
    );
  }
}

abstract class _MailerSendReq extends MailerSendReq {
  const factory _MailerSendReq(
      {final String? senderAddress,
      final String? title,
      final String? body,
      final List<Recipient>? recipients,
      final bool? individual,
      final bool? advertising}) = _$_MailerSendReq;
  const _MailerSendReq._() : super._();

  factory _MailerSendReq.fromJson(Map<String, dynamic> json) =
      _$_MailerSendReq.fromJson;

  @override
  String? get senderAddress;
  @override
  String? get title;
  @override
  String? get body;
  @override
  List<Recipient>? get recipients;
  @override
  bool? get individual;
  @override
  bool? get advertising;
  @override
  @JsonKey(ignore: true)
  _$$_MailerSendReqCopyWith<_$_MailerSendReq> get copyWith =>
      throw _privateConstructorUsedError;
}

Recipient _$RecipientFromJson(Map<String, dynamic> json) {
  return _Recipient.fromJson(json);
}

/// @nodoc
mixin _$Recipient {
  String? get address => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  Map<String, String>? get parameters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipientCopyWith<Recipient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientCopyWith<$Res> {
  factory $RecipientCopyWith(Recipient value, $Res Function(Recipient) then) =
      _$RecipientCopyWithImpl<$Res, Recipient>;
  @useResult
  $Res call(
      {String? address,
      String? name,
      String? type,
      Map<String, String>? parameters});
}

/// @nodoc
class _$RecipientCopyWithImpl<$Res, $Val extends Recipient>
    implements $RecipientCopyWith<$Res> {
  _$RecipientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_value.copyWith(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipientCopyWith<$Res> implements $RecipientCopyWith<$Res> {
  factory _$$_RecipientCopyWith(
          _$_Recipient value, $Res Function(_$_Recipient) then) =
      __$$_RecipientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? address,
      String? name,
      String? type,
      Map<String, String>? parameters});
}

/// @nodoc
class __$$_RecipientCopyWithImpl<$Res>
    extends _$RecipientCopyWithImpl<$Res, _$_Recipient>
    implements _$$_RecipientCopyWith<$Res> {
  __$$_RecipientCopyWithImpl(
      _$_Recipient _value, $Res Function(_$_Recipient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? parameters = freezed,
  }) {
    return _then(_$_Recipient(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Recipient extends _Recipient {
  const _$_Recipient(
      {this.address,
      this.name,
      this.type,
      final Map<String, String>? parameters})
      : _parameters = parameters,
        super._();

  factory _$_Recipient.fromJson(Map<String, dynamic> json) =>
      _$$_RecipientFromJson(json);

  @override
  final String? address;
  @override
  final String? name;
  @override
  final String? type;
  final Map<String, String>? _parameters;
  @override
  Map<String, String>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Recipient(address: $address, name: $name, type: $type, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Recipient &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, type,
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipientCopyWith<_$_Recipient> get copyWith =>
      __$$_RecipientCopyWithImpl<_$_Recipient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecipientToJson(
      this,
    );
  }
}

abstract class _Recipient extends Recipient {
  const factory _Recipient(
      {final String? address,
      final String? name,
      final String? type,
      final Map<String, String>? parameters}) = _$_Recipient;
  const _Recipient._() : super._();

  factory _Recipient.fromJson(Map<String, dynamic> json) =
      _$_Recipient.fromJson;

  @override
  String? get address;
  @override
  String? get name;
  @override
  String? get type;
  @override
  Map<String, String>? get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_RecipientCopyWith<_$_Recipient> get copyWith =>
      throw _privateConstructorUsedError;
}
