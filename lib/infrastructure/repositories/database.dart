import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class QuizAppDatabaseService {
  static Db? _db;
  static QuizAppDatabaseService get I => _instance;
  static final QuizAppDatabaseService _instance =
      QuizAppDatabaseService._internal();
  factory QuizAppDatabaseService() => _instance;
  QuizAppDatabaseService._internal();

  Future<void> init() async {
    _db = await Db.create(DatabaseConstants.databaseConnUrl);
    await _db?.open();
  }

  Db? getConnection() {
    return _db;
  }
}
