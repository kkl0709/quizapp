import 'package:chinesequizapp/Screens/QuestionScreen/views/consult_call_screen.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/model/reserve_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultCallController extends GetxController {
  late final DateTime date;
  final phoneTEC = TextEditingController().obs;
  RxString testString = "".obs;
  late final ReserveModel reserveModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final ConsultCallScreenArgs consultCallScreenArgs = Get.arguments as ConsultCallScreenArgs;
    date = consultCallScreenArgs.date;
    reserveModel = consultCallScreenArgs.reserveModel;
    debugPrint('ConsultCallController onInit  ${consultCallScreenArgs.date} ${reserveModel.userEmail}');
  }

  void tecChanged() {
    update();
  }
}
