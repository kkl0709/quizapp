import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  Rx<Color> bgColor = Colors.white.obs;
  RxInt totalPlatform = 5.obs;

  Rx<String> languageString = 'KOR'.obs;
  RxList<String> languageList = [
    'KOR',
    'ENG',
    'AFR',
    'ARA',
    'FRE',
    'GER',
    'HIN',
    'ITA',
    'JPN',
    'POR',
    'RUS',
    'CHI',
    'SPA',
  ].obs;

  RxList<List<String>> localeList = [
    ['ko', 'KR'],
    ['en', 'US'],
    ['af', 'ZA'],
    ['ar', 'AR'],
    ['fr', 'FR'],
    ['de', 'AT'],
    ['hi', 'IN'],
    ['it', 'IT'],
    ['ja', 'JP'],
    ['pt', 'PT'],
    ['ru', 'RU'],
    ['zh', 'CN'],
    ['es', 'ES'],
  ].obs;

  RxList<String> locale = ['ko', 'KR'].obs;

  @override
  void onInit() async {
    // print('onBoardingController init');
    await SharedPreferenceService.getLocale().then((value) {
      locale.value = value;
      if (value[0] == localeList[0][0]) {
        languageString.value = languageList[0];
      } else if (value[0] == localeList[1][0]) {
        languageString.value = languageList[1];
      } else if (value[0] == localeList[2][0]) {
        languageString.value = languageList[2];
      } else if (value[0] == localeList[3][0]) {
        languageString.value = languageList[3];
      } else if (value[0] == localeList[4][0]) {
        languageString.value = languageList[4];
      } else if (value[0] == localeList[5][0]) {
        languageString.value = languageList[5];
      } else if (value[0] == localeList[6][0]) {
        languageString.value = languageList[6];
      } else if (value[0] == localeList[7][0]) {
        languageString.value = languageList[7];
      } else if (value[0] == localeList[8][0]) {
        languageString.value = languageList[8];
      } else if (value[0] == localeList[9][0]) {
        languageString.value = languageList[9];
      } else if (value[0] == localeList[10][0]) {
        languageString.value = languageList[10];
      } else if (value[0] == localeList[11][0]) {
        languageString.value = languageList[11];
      } else if (value[0] == localeList[12][0]) {
        languageString.value = languageList[12];
      }
    });

    // print('onBoardingController init locale : ${locale.value}');
    // print('onBoardingController init language : ${languageString.value}');
    super.onInit();
  }
}
