import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LectureScreenController extends GetxController {
  Rx<Color> bgColor = AppConstantsColor.whiteColor.obs;

  late List<dynamic> lectureList;

  @override
  void onInit() async {
    refreshState();
    super.onInit();
  }

  void refreshState() async {
    lectureList = List.filled(5, {}).map((e) => {
      'imgUrl': 'https://images.unsplash.com/photo-1606761568499-6d2451b23c66?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80',
      'title': '1강. 테트라란 무엇인가?',
      'price': 9900,
    }).toList();
  }
}
