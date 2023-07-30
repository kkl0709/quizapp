// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailer_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MailerSendReq _$$_MailerSendReqFromJson(Map<String, dynamic> json) =>
    _$_MailerSendReq(
      senderAddress: json['senderAddress'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => Recipient.fromJson(e as Map<String, dynamic>))
          .toList(),
      individual: json['individual'] as bool?,
      advertising: json['advertising'] as bool?,
    );

Map<String, dynamic> _$$_MailerSendReqToJson(_$_MailerSendReq instance) =>
    <String, dynamic>{
      'senderAddress': instance.senderAddress,
      'title': instance.title,
      'body': instance.body,
      'recipients': instance.recipients,
      'individual': instance.individual,
      'advertising': instance.advertising,
    };

_$_Recipient _$$_RecipientFromJson(Map<String, dynamic> json) => _$_Recipient(
      address: json['address'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      parameters: (json['parameters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_RecipientToJson(_$_Recipient instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'type': instance.type,
      'parameters': instance.parameters,
    };
