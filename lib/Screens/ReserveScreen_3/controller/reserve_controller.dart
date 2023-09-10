import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReserveController extends GetxController {
  Rx<DateRangePickerController> datePickerController = DateRangePickerController().obs;
  Rx<DateTime> currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).obs;
  Rx<DateTime> selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).obs;
}
