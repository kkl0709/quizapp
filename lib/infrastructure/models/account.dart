import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    // 0: email, 1: kakao, 2: naver, 3: google, 4: apple, 5: fb
    @Default(0) int? authType,
    String? email,
    String? password,
    String? name,
    String? nickname,
    String? profileUrl,
    int? birthday,
    int? gender, // 0 : 남자, 1: 여자
    DateTime? createdAt,
  }) = _Account;

  static const empty = Account();

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}
