import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/models/statistic.dart';

abstract class IStatisticRepository {
  Future<DatabaseResp> initStatistic(String email);
  Future<DatabaseResp> updateStatistic(Statistic statistic, bool isCorrect);
  Future<DatabaseResp> updateStatisticEmail(String email, String newEmail);
  Future<DatabaseResp> getStatistic(String email);
  Future<DatabaseResp> deleteStatistic(String email);

  Future<DatabaseResp> initStatisticFirestore(String email);
  Future<DatabaseResp> updateStatisticFirestore(Statistic statistic, bool isCorrect);
  Future<DatabaseResp> updateStatisticEmailFirestore(String email, String newEmail);
  Future<DatabaseResp> getStatisticFirestore(String email);
  Future<DatabaseResp> deleteStatisticFirestore(String email);
}
