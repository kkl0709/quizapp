// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DatabaseResp _$$_DatabaseRespFromJson(Map<String, dynamic> json) =>
    _$_DatabaseResp(
      data: json['data'],
      isException: json['isException'] as bool?,
      error: $enumDecodeNullable(_$DbRespErrorEnumMap, json['error']),
    );

Map<String, dynamic> _$$_DatabaseRespToJson(_$_DatabaseResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isException': instance.isException,
      'error': _$DbRespErrorEnumMap[instance.error],
    };

const _$DbRespErrorEnumMap = {
  DbRespError.registrationFailed: 'registrationFailed',
  DbRespError.emailExists: 'emailExists',
  DbRespError.wrongAccount: 'wrongAccount',
  DbRespError.wrongPassword: 'wrongPassword',
  DbRespError.failedLoadingAccount: 'failedLoadingAccount',
  DbRespError.failedUpdatingAccount: 'failedUpdatingAccount',
  DbRespError.failedDeletingAccount: 'failedDeletingAccount',
  DbRespError.failedChangingPassword: 'failedChangingPassword',
  DbRespError.snsAccountNotExists: 'snsAccountNotExists',
  DbRespError.failedLoadingStatistic: 'failedLoadingStatistic',
  DbRespError.failedAddingStatistic: 'failedAddingStatistic',
  DbRespError.failedReplacingStatistic: 'failedReplacingStatistic',
  DbRespError.failedUpdatingEmail: 'failedUpdatingEmail',
  DbRespError.alreadySubmittedToday: 'alreadySubmittedToday',
  DbRespError.failedDeletingStatistic: 'failedDeletingStatistic',
  DbRespError.failedLoadingQuestion: 'failedLoadingQuestion',
};
