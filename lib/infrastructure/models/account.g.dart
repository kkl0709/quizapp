// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$$_AccountFromJson(Map<String, dynamic> json) => _$_Account(
      authType: json['authType'] as int? ?? 0,
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      profileUrl: json['profileUrl'] as String?,
      birthday: json['birthday'] as int?,
      gender: json['gender'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'authType': instance.authType,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'nickname': instance.nickname,
      'profileUrl': instance.profileUrl,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
