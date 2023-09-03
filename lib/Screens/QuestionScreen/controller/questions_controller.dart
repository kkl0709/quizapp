import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  final pageController = PageController();
  final listTEC = List.generate(16, (index) => TextEditingController());
  RxInt currentPage = 0.obs;

  void tecChanged() {
    debugPrint('refresh');
    update();
  }
}
