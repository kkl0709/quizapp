import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/date_object.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/models/statistic.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/interfaces/statistic_interface.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class StatisticRepository implements IStatisticRepository {
  final String _collection = DatabaseConstants.databaseStatisticsCollection;
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  @override
  Future<DatabaseResp> initStatistic(String email) async {
    final WriteResult? statistic = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .insertOne(Statistic.init(email).toJson());

    if (statistic == null) {
      return DatabaseResp.error(error: DbRespError.failedAddingStatistic);
    } else {
      return DatabaseResp.success();
    }
  }

  @override
  Future<DatabaseResp> getStatistic(String email) async {
    final Map<String, dynamic>? statistic = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .findOne({"email": email});
    if (statistic == null) {
      return DatabaseResp.error(error: DbRespError.failedLoadingStatistic);
    } else {
      return DatabaseResp.success(data: Statistic.fromJson(statistic));
    }
  }

  @override
  Future<DatabaseResp> updateStatistic(
      Statistic statistic, bool isCorrect) async {
    DateTime today = DateTime.now();
    if (today.year == statistic.lastSubmittedAt?.year &&
        today.month == statistic.lastSubmittedAt?.month &&
        today.day == statistic.lastSubmittedAt?.day) {
      return DatabaseResp.error(error: DbRespError.alreadySubmittedToday);
    }
    DateObject todayObj = DateObject(
      today.year,
      today.month,
      today.day,
    );
    List<DateObject> newDateList = List.from(statistic.dateList);
    newDateList.add(todayObj);

    List<MonthlyAccuracy> accuracyList = List.from(statistic.acurracyList);
    MonthlyAccuracy? monthlyAccuracy = accuracyList.firstWhereOrNull((date) =>
        date.month?.year == today.year && date.month?.month == today.month);

    /// When there is no accuracy for the current month
    if (monthlyAccuracy == null) {
      accuracyList.add(
        MonthlyAccuracy(
          DateObject(todayObj.year, todayObj.month, 0),
          isCorrect ? 1 : 0,
          1,
        ),
      );
    } else {
      if (monthlyAccuracy.totalCorrected != null &&
          monthlyAccuracy.totalSolved != null) {
        int newTotalCorrected =
            monthlyAccuracy.totalCorrected! + (isCorrect ? 1 : 0);
        int newTotalSolved = monthlyAccuracy.totalSolved! + 1;
        // final newMonthlyAccuracy = monthlyAccuracy.copyWith(
        //   totalCorrected: newTotalCorrected,
        //   totalSolved: newTotalSolved,
        // );
        final MonthlyAccuracy newMonthlyAccuracy = MonthlyAccuracy(
          monthlyAccuracy.month,
          newTotalCorrected,
          newTotalSolved,
        );

        accuracyList.removeWhere((date) =>
            date.month?.year == today.year && date.month?.month == today.month);
        accuracyList.add(newMonthlyAccuracy);
      }
    }
    int updatedTotalSolved = (statistic.totalSolved ?? 0) + 1;
    int updatedLevel = updatedTotalSolved ~/ 10;
    updatedLevel = (updatedLevel > 5) ? 5 : updatedLevel;

    Statistic updatedStatistic = statistic.copyWith(
        lastSubmittedAt: todayObj,
        dateList: newDateList,
        acurracyList: accuracyList,
        totalSolved: updatedTotalSolved,
        level: updatedLevel);
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .replaceOne(
            where.eq("email", statistic.email), updatedStatistic.toJson());
    // .updateOne(where.eq("email", email), modify.set("password", password));

    if (result?.document != null) {
      return DatabaseResp.success(data: Statistic.fromJson(result!.document!));
    } else {
      return DatabaseResp.error(error: DbRespError.failedLoadingStatistic);
    }
  }

  @override
  Future<DatabaseResp> updateStatisticEmail(
      String email, String newEmail) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .updateOne(
          where.eq('email', email),
          modify.set('email', newEmail),
        );
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedUpdatingEmail);
    } else {
      return DatabaseResp.success();
    }
  }

  @override
  Future<DatabaseResp> deleteStatistic(String email) async {
    final WriteResult? result = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection)
        .deleteOne({'email': email});
    if (result?.isFailure == true) {
      return DatabaseResp.error(error: DbRespError.failedDeletingAccount);
    } else {
      return DatabaseResp.success();
    }
  }
}
