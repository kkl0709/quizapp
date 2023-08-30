import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';

abstract class IAccountRepository {
  Future<DatabaseResp> validateAccount(String email);

  Future<DatabaseResp> login(String email, String password);

  Future<DatabaseResp> resetPassword(String email, String password, {int? authType});

  Future<DatabaseResp> createAccount(Account account);

  Future<DatabaseResp> updateAccount(String email, String newEmail, int birthday);

  Future<DatabaseResp> getAccountByEmail(String email);

  Future<DatabaseResp> deleteAccount(String email);

  Future<DatabaseResp> validateAccountFirestore(String email);

  Future<DatabaseResp> loginFirestore(String email, String password);

  Future<DatabaseResp> resetPasswordFirestore(String email, String password, {int? authType});

  Future<DatabaseResp> createAccountFirestore(Account account);

  Future<DatabaseResp> updateAccountFirestore(String email, String newEmail, int birthday);

  Future<DatabaseResp> getAccountByEmailFirestore(String email);

  Future<DatabaseResp> deleteAccountFirestore(String email);
}
