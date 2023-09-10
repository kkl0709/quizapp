import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarMove extends StatelessWidget {
  final DateTime currentDate;
  final DateRangePickerController controller;

  CalendarMove({
    super.key,
    required this.currentDate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(),
        GestureDetector(
            onTap: () {
              DateTime tempDate = DateTime(currentDate.year, currentDate.month - 1, 1);
              controller.displayDate = tempDate;
            },
            child: Image.asset('assets/images/left.png', width: 24)),
        Column(
          children: [
            Text(
              '${(currentDate.year)}' + "questionScreen_year".tr,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                overflow: TextOverflow.clip,
              ),
            ),
            Text(
              '${(currentDate.month)}' + "questionScreen_month".tr,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              DateTime tempDate = DateTime(currentDate.year, currentDate.month + 1, 1);
              debugPrint('${controller.displayDate}');
              controller.displayDate = tempDate;
            },
            child: Image.asset('assets/images/right.png', width: 24)),
        SizedBox(),
      ],
    );
  }
}

class DateBgStyle extends StatelessWidget {
  final DateTime date;
  final Color bgColor;

  const DateBgStyle({
    super.key,
    required this.date,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
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
            date.day.toString(),
            style: TextStyle(
              color: AppConstantsColor.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
