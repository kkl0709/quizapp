import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';

class SwitchLanguage {
  var language;
  static var databaseQuestionsCollection = "";

  Future<void> setLanguage() async {
    language = SharedPreferenceService.getLocale().then(
      (value) {
        if (value.toString() == '[af, ZA]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_af";
        }
        if (value.toString() == '[ar, AR]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_ar";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[de, AT]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_ge";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[en, US]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_en";
          return databaseQuestionsCollection;
        }
        if (value == '[es, ES]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_sp";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[fr, FR]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_fr";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[hi, IN]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_hi";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[it, IT]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_it";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[ja, JP]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_jp";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[ko, KR]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_ko";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[pt, PT]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_po";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[ru, RU]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_ru";
          return databaseQuestionsCollection;
        }
        if (value.toString() == '[zh, CN]') {
          DatabaseConstants.databaseQuestionsCollection = "questions_ch";
          return databaseQuestionsCollection;
        }
        return databaseQuestionsCollection;
      },
    );
    print(databaseQuestionsCollection);
  }
}
