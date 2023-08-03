import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';

abstract class IAccountRepository {
  Future<DatabaseResp> validateAccount(String email);
  Future<DatabaseResp> login(String email, String password);
  Future<DatabaseResp> resetPassword(String email, String password,
      {int? authType});
  Future<DatabaseResp> createAccount(Account account);
  Future<DatabaseResp> updateAccount(
      String email, String newEmail, int birthday);
  Future<DatabaseResp> updateProfile(String email, {
    required String nickname,
    String? profileUrl,
  });
  Future<DatabaseResp> getAccountByEmail(String email);
  Future<DatabaseResp> deleteAccount(String email);
}
