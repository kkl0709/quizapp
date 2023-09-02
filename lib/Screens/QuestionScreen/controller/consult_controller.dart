import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ConsultController extends GetxController {
  Rx<DateRangePickerController> datePickerController = DateRangePickerController().obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<String> noReserveDate = <String>[].obs;
  RxList<DateTime> testList = <DateTime>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final document = await QuizAppDatabaseService.I
        .getConnection()
        ?.collection('noReserveDate')
        .findOne({'_id': 'noReserveDate'});

    if (document != null) {
      List<dynamic> rawList = document['noReserveDate'];
      debugPrint('onInit!!');

      noReserveDate.value = rawList.map((e) => e.toString()).toList();

      // noReserveDate 이걸 구독하고 있지 않으면 위 처럼 리턴을 다시 해도 리빌드를 안한다
      currentDate.value = DateTime.now();
      // 위처럼 currentDate.value = DateTime.now();을 하는 이유는 이것을 해당 위젯에서 사용하고 있기 때문
      // 이제 noReserveDateList를 사용하여 원하는 작업을 수행하면 됩니다.
    }
  }
}
