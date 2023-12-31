import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/models/daily_question.dart';
import 'package:chinesequizapp/infrastructure/models/date_object.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/interfaces/quiz_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionRepository implements IQuestionRepository {
  final String? _collection = DatabaseConstants.databaseQuestionsCollection;
  final CollectionReference _collectionFirestore = FirebaseFirestore.instance.collection(DatabaseConstants.databaseQuestionsCollection!);
  final QuizAppDatabaseService db = QuizAppDatabaseService.I;

  @override
  Future<DatabaseResp> getTodaysQuestion({DateTime? date}) async {
    DateTime dateTime = date ?? DateTime.now();
    final Map<String, dynamic>? question = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection(_collection!)
        .findOne({
      "date": DateObject(
        dateTime.year,
        dateTime.month,
        dateTime.day,
      ).toJson()
    });
    print(question);

    if (question == null) {
      return DatabaseResp.error(error: DbRespError.failedLoadingQuestion);
    } else {
      return DatabaseResp.success(data: DailyQuestion.fromJson(question));
    }
  }

  @override
  Future<DatabaseResp> getTodaysQuestionFirestore({DateTime? date}) async {
    DateTime dateTime = date ?? DateTime.now();
    try {
      QuerySnapshot querySnapshot = await _collectionFirestore.where("date", isEqualTo: DateObject(
        dateTime.year,
        dateTime.month,
        dateTime.day,
      ).toJson()).get();
      if (querySnapshot.docs.length == 0) {
        return DatabaseResp.error(error: DbRespError.failedLoadingQuestion);
      } else {
        return DatabaseResp.success(data: DailyQuestion.fromJson(querySnapshot.docs[0].data()! as Map<String, dynamic>));
      }
    } catch (e) {
      return DatabaseResp.error(error: DbRespError.failedLoadingQuestion);
    }
  }
}
