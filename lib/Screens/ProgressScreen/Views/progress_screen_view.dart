import 'package:chinesequizapp/Screens/ProgressScreen/controller/progress_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../Behaviour/behaviour.dart';

class ProgressScreen extends GetView<ProgressScreenController> {
  @override
  Widget build(BuildContext context) {
    controller.loadStatisticData();

    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          "progressScreen_progress".tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(
                          Icons.circle,
                          size: 15.0,
                          color: Color(0xff59287b),
                        ),
                        Text(
                          "progressScreen_quizComplete".tr,
                          style: TextStyle(
                              color: Color(0xff59287b),
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10),
                    child: SfDateRangePicker(
                      controller: controller.datePickerController.value,
                      selectionColor: Colors.transparent,
                      cellBuilder: (context, cellDetails) {
                        DateTime nowDt = DateTime.now();
                        bool isActive = controller.answerDtList.indexWhere((e) => Utils.isSameDay(e, cellDetails.date)) >= 0;
                        bool isAfter = cellDetails.date.isAfter(nowDt.subtract(Duration(days: 1)));

                        if (isActive) {
                          return Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                              AppConstantsColor.basicColor.withOpacity(0.9),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 10.0,
                                  color: AppConstantsColor.whiteColor,
                                ),
                                Text(
                                  cellDetails.date.day.toString(),
                                  style: TextStyle(
                                    color: AppConstantsColor.whiteColor,
                                    fontWeight: FontWeight.w500,
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
                              color: AppConstantsColor.normalTextColor
                                  .withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      onSelectionChanged: (value) {},
                      selectionMode: DateRangePickerSelectionMode.single,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderHeight: 50,
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontFamily: "",
                            fontSize: 16,
                            color:
                                AppConstantsColor.titleColor.withOpacity(0.3),
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
                  Divider(
                    color: Colors.grey.shade300,
                    height: 0.0,
                    thickness: 10.0,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    child: Text(
                      "progressScreen_levelTitle".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      controller.sliderValue.value == 0
                          ? "progressScreen_levelRate".tr
                          : "progressScreen_levelRate1".tr +
                              " ${5 - controller.sliderValue.value.toInt()} " +
                              "progressScreen_levelRate2".tr,
                      style: TextStyle(
                          color: Color(0xff59287b),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                        valueIndicatorTextStyle: const TextStyle(
                          color: Color(0xff59287b),
                          fontWeight: FontWeight.w700,
                        ),
                        trackHeight: 10.0,
                        valueIndicatorShape: MySliderComponentShape(),
                        rangeValueIndicatorShape:
                            const RectangularRangeSliderValueIndicatorShape()),
                    child: Slider(
                      divisions: 5,
                      value: controller.sliderValue.value,
                      onChanged: (value) => null,
                      activeColor: const Color(0xff59287b),
                      inactiveColor: Colors.grey.shade200,
                      min: 0,
                      max: 5,
                      label: "Level. ${controller.sliderValue.value.toInt()}",
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Text(
                            "Level ${controller.sliderValue.value.toInt()}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    secondChild: Container(),
                    crossFadeState: controller.sliderValue.value == 0
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstCurve: Curves.linear,
                    duration: Duration(milliseconds: 400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20, top: 40),
                    child: Text(
                      "progressScreen_answerTitle".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "progressScreen_deliveryRate".tr +
                                        " : " +
                                        "${controller.prevAccuracy.toInt()}%",
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "progressScreen_monthAnswer".tr,
                                    style: TextStyle(
                                        color: AppConstantsColor.titleColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "progressScreen_completeQuizTitle"
                                                      .tr +
                                                  " ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                          text: "progressScreen_completeQuizTotal1"
                                                  .tr +
                                              " ${controller.statistic.value.totalSolved} " +
                                              "progressScreen_completeQuizTotal2"
                                                  .tr,
                                          style: TextStyle(
                                              color: Color(0xffd86aad),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       "progressScreen_completeQuizTitle".tr +
                                //           " ",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 14.0,
                                //           fontWeight: FontWeight.w700),
                                //     ),
                                //     Text(
                                //       "progressScreen_completeQuizTotal1".tr +
                                //           " ${controller.statistic.value.totalSolved} " +
                                //           "progressScreen_completeQuizTotal2"
                                //               .tr,
                                //       style: TextStyle(
                                //           color: Color(0xffd86aad),
                                //           fontSize: 14.0,
                                //           fontWeight: FontWeight.w700),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    "progressScreen_month".tr,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${controller.accuracy.toInt()}%",
                                  style: TextStyle(
                                      color: Color(0xff59287b),
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
