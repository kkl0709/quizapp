import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyQuizController extends GetxController {


  
 
  Rx<Color> bgColor = AppConstantsColor.whiteColor.obs;

  Rx<DateTime> currentDateTime = DateTime.now().obs;

  RxInt selectedAns = 2.obs;

  RxBool isAnswer = false.obs;

  RxBool isClick = false.obs;
}

