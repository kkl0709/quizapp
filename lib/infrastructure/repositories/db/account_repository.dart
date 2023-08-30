import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/mixins/authentication_mixin.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/interfaces/account_repository_interface.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/statistic_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AccountRepository implements IAccountRepository {
  final String _collection = DatabaseConstants.databaseAccountsCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  final _firestore = FirebaseFirestore.instance;

  Future<DatabaseResp> validateAccount(String email) async {
    final Map<String, dynamic>? document =
        await QuizAppDatabaseService.I.getConnection()?.collection(_collection).findOne({"email": email});
    if (document != null) {
      return DatabaseResp.error(error: DbRespError.emailExists);
    } else {
      return DatabaseResp.success();
    }
  }

  Future<DatabaseResp> validateAccountFirestore(String email) async {
    try {
      final documents = await _firestore.collection(_collection).where("email", isEqualTo: email).get();

      if (documents.docs.isNotEmpty) {
        return DatabaseResp.error(error: DbRespError.emailExists);
      } else {
        return DatabaseResp.success();
      }
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.emailExists);
    }
  }

  Future<DatabaseResp> validateAccountByAuth(String email, {required AuthType authType}) async {
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

  // 2.
  Future<DatabaseResp> validateAccountByAuthFirestore(String email, {required AuthType authType}) async {
    try {
      final documents = await _firestore
          .collection(_collection)
          .where("email", isEqualTo: email)
          .where("authType", isEqualTo: authType.code)
          .get();

      if (documents.docs.isNotEmpty) {
        return DatabaseResp.success();
      } else {
        return DatabaseResp.error(error: DbRespError.emailExists);
      }
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.emailExists);
    }
  }

  @override
  Future<DatabaseResp> resetPassword(String email, String password, {int? authType}) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .updateOne(where.eq("email", email).eq("authType", authType ?? 0), modify.set("password", password));

    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedChangingPassword);
    } else {
      return DatabaseResp.success();
    }
  }

  // 3.
  Future<DatabaseResp> resetPasswordFirestore(String email, String password, {int? authType}) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(email)
          .update({"password": password, "authType": authType ?? 0});
      return DatabaseResp.success();
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.failedChangingPassword);
    }
  }

  @override
  Future<DatabaseResp> getAccountByEmail(String email) async {
    final Map<String, dynamic>? document =
        await QuizAppDatabaseService.I.getConnection()?.collection(_collection).findOne({"email": email});
    if (document == null) {
      return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
    } else {
      return DatabaseResp.success(data: Account.fromJson(document));
    }
  }

  // 4.
  Future<DatabaseResp> getAccountByEmailFirestore(String email) async {
    try {
      final document = await _firestore.collection(_collection).doc(email).get();
      if (document.exists) {
        return DatabaseResp.success(data: Account.fromJson(document.data()!));
      } else {
        return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
      }
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.failedLoadingAccount);
    }
  }

  @override
  Future<DatabaseResp> createAccount(Account account) async {
    final WriteResult? result =
        await QuizAppDatabaseService.I.getConnection()?.collection(_collection).insertOne(account.toJson());
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

  // 5.
  Future<DatabaseResp> createAccountFirestore(Account account) async {
    try {
      await _firestore.collection(_collection).doc(account.email).set(account.toJson());
      return DatabaseResp.success(data: account);
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.registrationFailed);
    }
  }

  @override
  Future<DatabaseResp> login(String email, String password) async {
    final emailExists =
        await QuizAppDatabaseService.I.getConnection()?.collection(_collection).findOne({"email": email}) !=
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

  // 6.
  Future<DatabaseResp> loginFirestore(String email, String password) async {
    try {
      final documents = await _firestore
          .collection(_collection)
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();

      if (documents.docs.isEmpty) {
        return DatabaseResp.error(error: DbRespError.wrongPassword);
      }

      return DatabaseResp.success(data: Account.fromJson(documents.docs.first.data()));
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.wrongAccount);
    }
  }

  @override
  Future<DatabaseResp> updateAccount(String email, String newEmail, int birthday) async {
    WriteResult? result;
    if (email == newEmail) {
      result = await QuizAppDatabaseService.I.getConnection()?.collection(_collection).updateOne(
            where.eq('email', email),
            modify.set('birthday', birthday),
          );
    } else {
      result = await QuizAppDatabaseService.I.getConnection()?.collection(_collection).updateOne(
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

  @override
  Future<DatabaseResp> updateAccountFirestore(String email, String newEmail, int birthday) async {
    try {
      final documents = await _firestore.collection(_collection).where("email", isEqualTo: email).get();

      if (documents.docs.isEmpty) {
        return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
      }

      if (email == newEmail) {
        await _firestore.collection(_collection).doc(documents.docs.first.id).update({"birthday": birthday});
      } else {
        await _firestore
            .collection(_collection)
            .doc(documents.docs.first.id)
            .update({"email": newEmail, "birthday": birthday});
      }

      final StatisticRepository statisticRepo = StatisticRepository();
      await statisticRepo.updateStatisticEmail(email, newEmail);

      return DatabaseResp.success();
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
    }
  }

  Future<DatabaseResp> updateProfile(
    String email, {
    required String newEmail,
    required int birthday,
    String? profileUrl,
  }) async {
    WriteResult? result = await QuizAppDatabaseService.I.getConnection()?.collection(_collection).updateOne(
          where.eq('email', email),
          modify.set('profileUrl', profileUrl).set('email', newEmail).set('birthday', birthday),
        );
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
    } else {
      final StatisticRepository statisticRepo = StatisticRepository();
      await statisticRepo.updateStatisticEmail(email, newEmail);

      return DatabaseResp.success();
    }
  }

  // 8.
  Future<DatabaseResp> updateProfileFirestore(
    String email, {
    required String newEmail,
    required int birthday,
    String? profileUrl,
  }) async {
    try {
      final documents = await _firestore.collection(_collection).where("email", isEqualTo: email).get();

      if (documents.docs.isEmpty) {
        return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
      }

      await _firestore.collection(_collection).doc(documents.docs.first.id).update({
        "profileUrl": profileUrl,
        "email": newEmail,
        "birthday": birthday,
      });

      final StatisticRepository statisticRepo = StatisticRepository();
      await statisticRepo.updateStatisticEmail(email, newEmail);

      return DatabaseResp.success();
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.failedUpdatingAccount);
    }
  }

  @override
  Future<DatabaseResp> deleteAccount(String email) async {
    final WriteResult? result =
        await QuizAppDatabaseService.I.getConnection()?.collection(_collection).deleteOne({"email": email});
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedDeletingAccount);
    } else {
      final StatisticRepository statisticRepo = StatisticRepository();
      statisticRepo.deleteStatistic(email);
      return DatabaseResp.success();
    }
  }

  // 9.
  Future<DatabaseResp> deleteAccountFirestore(String email) async {
    try {
      final documents = await _firestore.collection(_collection).where("email", isEqualTo: email).get();

      if (documents.docs.isEmpty) {
        return DatabaseResp.error(error: DbRespError.failedDeletingAccount);
      }

      await _firestore.collection(_collection).doc(documents.docs.first.id).delete();

      final StatisticRepository statisticRepo = StatisticRepository();
      statisticRepo.deleteStatistic(email);
      return DatabaseResp.success();
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.failedDeletingAccount);
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

  // 10.
  Future<List<Account>> getAccountsFirestore() async {
    final documents = await _firestore.collection(_collection).orderBy("email").get();
    if (documents.docs.isNotEmpty) {
      return documents.docs.map((e) => Account.fromJson(e.data())).toList();
    }
    return [];
  }
}
