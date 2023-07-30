import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/date_object.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/models/statistic.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/statistic_repository.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProgressScreenController extends GetxController {
  Rx<Statistic> statistic = Statistic().obs;
  String? _email;
  final StatisticRepository _statRepository = StatisticRepository();
  RxDouble sliderValue = 0.0.obs;
  Rx<DateRangePickerController> datePickerController =
      DateRangePickerController().obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  Rx<DateTime> maxDate = DateTime.now().obs;
  Rx<DateTime> minDate = DateTime.now().obs;

  Rx<double> accuracy = 0.0.obs;
  Rx<double> prevAccuracy = 0.0.obs;

  @override
  void onInit() async {
    datePickerController.value.view = DateRangePickerView.month;
    datePickerController.value.selectedDates = [];
    maxDate.value = DateTime(currentDate.value.year, currentDate.value.month,
            currentDate.value.day)
        .add(Duration(days: 7));
    minDate.value = DateTime(currentDate.value.year, currentDate.value.month,
            currentDate.value.day)
        .subtract(Duration(days: 7));

    _email = await SharedPreferenceService.getLoggedInEmail;
    loadStatisticData();
    super.onInit();
  }

  void loadStatisticData() async {
    if (_email != null) {
      final DatabaseResp resp = await _statRepository.getStatistic(_email!);

      if (resp.isException == false && resp.data is Statistic) {
        statistic.value = resp.data;
        datePickerController.value.selectedDates = statistic.value.dateList
            .where((date) =>
                date.year == currentDate.value.year &&
                date.month == currentDate.value.month)
            .map((e) =>
                DateTime(e.year ?? 0, e.month ?? 0, e.day ?? 0, 0, 0, 0, 0, 0))
            .toList();
        ;

        MonthlyAccuracy? accuracy = statistic.value.acurracyList
            .firstWhereOrNull((element) =>
                element.month?.year == currentDate.value.year &&
                element.month?.month == currentDate.value.month);
        if (accuracy != null) {
          double monthlyAccuracy =
              (accuracy.totalCorrected?.toDouble() ?? 0.0) /
                  (accuracy.totalSolved?.toDouble() ?? 0.0) *
                  100.0;
          this.accuracy.value = monthlyAccuracy;
        }

        int prevMonth = currentDate.value.month;
        int prevYear = currentDate.value.year;
        if (prevMonth == 1) {
          prevMonth = 12;
          prevYear--;
        } else {
          prevMonth--;
        }

        MonthlyAccuracy? prevAccuracy = statistic.value.acurracyList
            .firstWhereOrNull((element) =>
                element.month?.year == prevYear &&
                element.month?.month == prevMonth);

        // accuracy.value =

        if (prevAccuracy != null) {
          double monthlyAccuracy =
              (prevAccuracy.totalCorrected?.toDouble() ?? 0.0) /
                  (prevAccuracy.totalSolved?.toDouble() ?? 0.0) *
                  100.0;
          this.prevAccuracy.value = monthlyAccuracy;
        }

        if (statistic.value.level != null) {
          sliderValue.value = statistic.value.level!.toDouble();
        }
      }
    }
  }
}
