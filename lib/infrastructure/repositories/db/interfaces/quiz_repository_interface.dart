import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';

abstract class IQuestionRepository {
  Future<DatabaseResp> getTodaysQuestion();
}
