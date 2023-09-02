import 'package:chinesequizapp/Screens/QuestionScreen/views/consult_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultCallController extends GetxController {
  late final DateTime date;
  late final String hour;
  final phoneTEC = TextEditingController().obs;
  RxString testString = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final ConsultCallScreenArgs consultCallScreenArgs = Get.arguments as ConsultCallScreenArgs;
    date = consultCallScreenArgs.date;
    hour = consultCallScreenArgs.hour;
    debugPrint('ConsultCallController onInit ${consultCallScreenArgs.hour} ${consultCallScreenArgs.date}');
  }

  void tecChanged() {
    update();
  }
}
