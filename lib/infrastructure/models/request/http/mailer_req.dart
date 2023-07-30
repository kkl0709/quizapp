import 'package:freezed_annotation/freezed_annotation.dart';
part 'mailer_req.freezed.dart';
part 'mailer_req.g.dart';

@freezed
class MailerSendReq with _$MailerSendReq {
  const MailerSendReq._();
  const factory MailerSendReq({
    String? senderAddress,
    String? title,
    String? body,
    List<Recipient>? recipients,
    bool? individual,
    bool? advertising,
  }) = _MailerSendReq;

  factory MailerSendReq.fromJson(Map<String, dynamic> json) =>
      _$MailerSendReqFromJson(json);
}

@freezed
class Recipient with _$Recipient {
  const Recipient._();
  const factory Recipient({
    String? address,
    String? name,
    String? type,
    Map<String, String>? parameters,
  }) = _Recipient;

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);
}
