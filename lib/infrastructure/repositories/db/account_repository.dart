import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/mixins/authentication_mixin.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/interfaces/account_repository_interface.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/statistic_repository.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AccountRepository implements IAccountRepository {
  final String _collection = DatabaseConstants.databaseAccountsCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  @override
  Future<DatabaseResp> validateAccount(String email) async {
    final Map<String, dynamic>? document = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .findOne({"email": email});
    if (document != null) {
      return DatabaseResp.error(error: DbRespError.emailExists);
    } else {
      return DatabaseResp.success();
    }
  }

  Future<DatabaseResp> validateAccountByAuth(String email,
      {required AuthType authType}) async {
    final Map<String, dynamic>? document = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .findOne({"email": email, "authType": authType.code});

    if (document != null) {
      return DatabaseResp.success();
    } else {
      return DatabaseResp.error(error: DbRespError.emailExists);
    }
  }

  @override
  Future<DatabaseResp> resetPassword(String email, String password,
      {int? authType}) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .updateOne(where.eq("email", email).eq("authType", authType ?? 0),
            modify.set("password", password));

    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedChangingPassword);
    } else {
      return DatabaseResp.success();
    }
  }

  @override
  Future<DatabaseResp> getAccountByEmail(String email) async {
    final Map<String, dynamic>? document = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .findOne({"email": email});
    if (document == null) {
      return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
    } else {
      return DatabaseResp.success(data: Account.fromJson(document));
    }
  }

  @override
  Future<DatabaseResp> createAccount(Account account) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .insertOne(account.toJson());
    if (result?.document != null) {
      if (account.email != null) {
        StatisticRepository repository = StatisticRepository();
        repository.initStatistic(account.email!);
      }
      return DatabaseResp.success(data: Account.fromJson(result!.document!));
    } else {
      return DatabaseResp.error(error: DbRespError.registrationFailed);
    }
  }

  @override
  Future<DatabaseResp> login(String email, String password) async {
    final emailExists = await QuizAppDatabaseService.I
            .getConnection()
            ?.collection(_collection)
            .findOne({"email": email}) !=
        null;

    final Map<String, dynamic>? document = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .findOne({"email": email, "password": password});
    if (document == null) {
      if (emailExists) {
        return DatabaseResp.error(error: DbRespError.wrongPassword);
      } else {
        return DatabaseResp.error(error: DbRespError.wrongAccount);
      }
    } else {
      return DatabaseResp.success(data: Account.fromJson(document));
    }
  }

  @override
  Future<DatabaseResp> updateAccount(
      String email, String newEmail, int birthday) async {
    WriteResult? result;
    if (email == newEmail) {
      result = await QuizAppDatabaseService.I
          .getConnection()
          ?.collection(_collection)
          .updateOne(
        where.eq('email', email),
        modify.set('birthday', birthday),
      );
    } else {
      result = await QuizAppDatabaseService.I
          .getConnection()
          ?.collection(_collection)
          .updateOne(
        where.eq('email', email),
        modify.set('email', newEmail).set('birthday', birthday),
      );
    }
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
    } else {
      final StatisticRepository statisticRepo = StatisticRepository();
      await statisticRepo.updateStatisticEmail(email, newEmail);

      return DatabaseResp.success();
    }
  }

  Future<DatabaseResp> updateProfile(String email, {
    required String newEmail,
    required int birthday,
    String? profileUrl,
  }) async {
    WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .updateOne(
      where.eq('email', email),
      modify.set('profileUrl', profileUrl)
          .set('email', newEmail)
          .set('birthday', birthday),
    );
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
    } else {
      final StatisticRepository statisticRepo = StatisticRepository();
      await statisticRepo.updateStatisticEmail(email, newEmail);

      return DatabaseResp.success();
    }
  }

  @override
  Future<DatabaseResp> deleteAccount(String email) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .deleteOne({"email": email});
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedDeletingAccount);
    } else {
      final StatisticRepository statisticRepo = StatisticRepository();
      statisticRepo.deleteStatistic(email);
      return DatabaseResp.success();
    }
  }

  Future<List<Account>> getAccounts() async {
    List<Map<String, dynamic>>? list = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .find(where.sortBy('email'))
        .toList();
    if (list != null) {
      return list.map((e) => Account.fromJson(e)).toList();
    }
    return [];
  }
}
