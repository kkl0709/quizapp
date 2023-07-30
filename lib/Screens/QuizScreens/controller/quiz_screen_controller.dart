import 'package:chinesequizapp/generated/switch_language.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/daily_question.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/models/statistic.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/question_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/statistic_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizScreenController extends GetxController {
  String? _email;
  Rx<Statistic> statistic = Statistic().obs;
  Rx<DateTime> currentDateTime = DateTime.now().obs;
  Rx<DailyQuestion> question = DailyQuestion().obs;
  final StatisticRepository _statisticRepository = StatisticRepository();
  final QuestionRepository _questionRepository = QuestionRepository();

  Rx<Color> bgColor = AppConstantsColor.whiteColor.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isQuizComplete = true.obs;
  RxList<String> locale = [''].obs;
  SwitchLanguage switchLanguage = SwitchLanguage();

  @override
  void onInit() async {
    isQuizComplete.value = false;
    isQuizComplete.refresh();
    switchLanguage.setLanguage();
    await SharedPreferenceService.getLocale().then((value) {
      locale.value = value;
    });

    _email = await SharedPreferenceService.getLoggedInEmail;
    refreshState();
    super.onInit();
  }

  void refreshState() async {
    bool isQuizCompleted = true;
    if (_email != null) {
      final DatabaseResp resp =
          await _statisticRepository.getStatistic(_email!);
      if (resp.data != null && resp.data is Statistic) {
        statistic.value = resp.data as Statistic;

        isQuizCompleted = hasCompletedQuiz;

        if (hasCompletedQuiz == false) {
          final DatabaseResp resp =
              await _questionRepository.getTodaysQuestion();

          if (resp.data is DailyQuestion) {
            question.value = resp.data;
          } else if (resp.data == null) {
            isQuizCompleted = true;
          }
        }
      }
    }
    isQuizComplete.value = isQuizCompleted;
  }

  bool get hasCompletedQuiz =>
      statistic.value.lastSubmittedAt?.year == currentDateTime.value.year &&
      statistic.value.lastSubmittedAt?.month == currentDateTime.value.month &&
      statistic.value.lastSubmittedAt?.day == currentDateTime.value.day;

  void onSubmit(int selectedAnswer) async {
    if (_email != null) {
      await _statisticRepository.updateStatistic(
          statistic.value, selectedAnswer == question.value.answer);
      refreshState();
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    // isQuizComplete.value = false;
    // isQuizComplete.refresh();
    refreshState();
  }
}
