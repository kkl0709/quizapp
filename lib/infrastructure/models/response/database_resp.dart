import 'package:freezed_annotation/freezed_annotation.dart';
part 'database_resp.freezed.dart';
part 'database_resp.g.dart';

enum DbRespError {
  /// Account Exception
  registrationFailed(11001, "계정 생성에 실패했습니다."),
  emailExists(11002, "이미 존재하는 이메일입니다."),
  wrongAccount(11003, "계정 정보를 확인해주세요."),
  wrongPassword(11004, "비밀번호를 확인해주세요."),
  failedLoadingAccount(11005, "계정정보가 없습니다."),
  failedUpdatingAccount(11005, "계정 정보를 업데이트할 수 없습니다."),
  failedDeletingAccount(11006, "계정을 삭제할 수 없습니다."),
  failedChangingPassword(11007, "비밀번호를 변경할 수 없습니다."),
  snsAccountNotExists(11008, "존재하지 않는 간편인증 계정입니다."),

  /// Statistic Exception
  failedLoadingStatistic(12001, "통계 정보 오류"),
  failedAddingStatistic(12002, "통계 등록 오류"),
  failedReplacingStatistic(12003, "통계 저장 오류"),
  failedUpdatingEmail(12004, "이메일을 변경할 수 없습니다."),
  alreadySubmittedToday(12005, "오늘 이미 문제를 풀었습니다."),
  failedDeletingStatistic(12006, "통계 데이터를 삭제할 수 없습니다."),

  /// Question Exception
  failedLoadingQuestion(13001, "질문 오류");

  const DbRespError(this.code, this.message);
  final int code;
  final String message;
}

@freezed
class DatabaseResp with _$DatabaseResp {
  const DatabaseResp._();
  const factory DatabaseResp({
    dynamic data,
    bool? isException,
    DbRespError? error,
  }) = _DatabaseResp;

  factory DatabaseResp.success({dynamic data}) =>
      DatabaseResp(isException: false, data: data);

  factory DatabaseResp.error({required DbRespError error}) =>
      DatabaseResp(isException: true, error: error);

  factory DatabaseResp.fromJson(Map<String, dynamic> json) =>
      _$DatabaseRespFromJson(json);
}
