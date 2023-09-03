import 'package:chinesequizapp/Screens/QuestionScreen/component/consult_component.dart';
import 'package:chinesequizapp/Screens/QuestionScreen/controller/consult_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ConsultScreen extends GetView<ConsultController> {
  const ConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        debugPrint('리빌드!!');
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                    SizedBox(width: 4.0),
                    //Text(controller.noReserveDate.toString())
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConsultReserve(
                  selectedDate: controller.selectedDate.value,
                  controller: controller,
                ),
                SizedBox(height: 15),
                CalendarMove(
                    currentDate: controller.currentDate.value,
                    controller: controller.datePickerController.value),
                SizedBox(height: 15),
                Expanded(
                  child: SfDateRangePicker(
                    onViewChanged: (dateRangePickerViewChangedArgs) async {
                      await Future.delayed(Duration(milliseconds: 100));
                      debugPrint('${controller.datePickerController.value.displayDate}');
                      controller.currentDate.value =
                          dateRangePickerViewChangedArgs.visibleDateRange.endDate ?? DateTime.now();
                      debugPrint('${controller.datePickerController.value.displayDate}');
                    },
                    controller: controller.datePickerController.value,
                    selectionColor: Colors.transparent,
                    cellBuilder: (context, cellDetails) {
                      DateTime nowDt = DateTime.now();
                      bool isAfter = cellDetails.date.isAfter(nowDt.subtract(Duration(days: 1)));
                      bool isSelected = cellDetails.date == controller.selectedDate.value;
                      bool isNoReserve =
                          compareNoReserve(noReserveDate: controller.noReserveDate, date: cellDetails.date);
                      bool isToday = (cellDetails.date.year == nowDt.year) &&
                          (cellDetails.date.month == nowDt.month) &&
                          (cellDetails.date.day == nowDt.day);

                      //debugPrint('$isNoReserve ${controller.noReserveDate}');

                      if (isToday) {
                        return DateBgStyle(
                            date: cellDetails.date,
                            bgColor: AppConstantsColor.normalTextColor.withOpacity(0.5));
                      }
                      if (isSelected) {
                        return DateBgStyle(
                            date: cellDetails.date, bgColor: AppConstantsColor.basicColor.withOpacity(0.9));
                      }
                      if (isNoReserve) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: Stack(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cellDetails.date.day.toString(),
                                style: TextStyle(
                                  color: AppConstantsColor.normalTextColor.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Positioned(
                                top: 6,
                                child: Container(
                                  width: 15,
                                  height: 1,
                                  color: AppConstantsColor.normalTextColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (isAfter) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: Text(
                            cellDetails.date.day.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        child: Text(
                          cellDetails.date.day.toString(),
                          style: TextStyle(
                            color: AppConstantsColor.normalTextColor.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    onSelectionChanged: (value) {
                      controller.selectedDate.value = value.value;
                      debugPrint('onSelectionChanged ${value.value}');
                    },
                    selectionMode: DateRangePickerSelectionMode.single,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderHeight: 50,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontFamily: "",
                          fontSize: 16,
                          color: AppConstantsColor.titleColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                    showActionButtons: false,
                    showNavigationArrow: false,
                    allowViewNavigation: false,
                    view: DateRangePickerView.month,
                    headerHeight: 0.0,
                  ),
                ),
                Image.asset('assets/images/boarder_line.png'),
                SizedBox(
                  height: 40.h,
                  child: !controller.noReserveDate.contains(controller.selectedDate.toString())
                      ? Column(
                          children: [
                            ...List.generate(
                              3,
                              (index) {
                                String hour = '';
                                if (index == 0) {
                                  hour = "questionScreen_am_9".tr;
                                } else if (index == 1) {
                                  hour = "questionScreen_am_11".tr;
                                } else {
                                  hour = "questionScreen_pm_5".tr;
                                }
                                return ReserveCard(
                                    date: controller.selectedDate.value ?? DateTime.now(), hour: hour);
                              },
                            )
                          ],
                        )
                      : null,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool compareNoReserve({required List<String> noReserveDate, required DateTime date}) {
    bool result = false;
    noReserveDate.map(
        (date) => DateTime(DateTime.parse(date).year, DateTime.parse(date).month, DateTime.parse(date).day));
    noReserveDate.forEach((date_1) {
      if (DateTime.parse(date_1).year == date.year &&
          DateTime.parse(date_1).month == date.month &&
          DateTime.parse(date_1).day == date.day) {
        result = true;
      }
    });
    return result;
  }
}
