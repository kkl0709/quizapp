import 'package:chinesequizapp/generated/switch_language.dart';

class DatabaseConstants {
  // static const String databaseConnUrl =
  //     "mongodb://user1234:user1234@49.50.165.125:27017/quiz";
  static const String databaseConnUrl =
      "mongodb://user1234:user1234@49.50.165.125:27017/quiz";
  static const String databaseAccountsCollection = "accounts";
  static String? databaseQuestionsCollection =
      SwitchLanguage.databaseQuestionsCollection;
  static const String databaseStatisticsCollection = "statistics";
  static const String databaseVersionCollection = "version";
  static const String databaseLectureCollection = "lecture";

  set setDatabaseQuestionsCollection(String databaseQuestionsCollection) =>
      databaseQuestionsCollection = databaseQuestionsCollection;
  String get getDatabaseQuestionsCollection => databaseQuestionsCollection!;
}
