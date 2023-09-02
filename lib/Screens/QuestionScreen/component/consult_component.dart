import 'package:chinesequizapp/Screens/QuestionScreen/controller/consult_controller.dart';
import 'package:chinesequizapp/Screens/QuestionScreen/views/consult_call_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ConsultReserve extends StatelessWidget {
  final DateTime? selectedDate;
  final ConsultController controller;

  const ConsultReserve({
    super.key,
    required this.selectedDate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "questionScreen_consultTimeReserve".tr,
          style: TextStyle(color: Color(0xFF1E1F27), fontSize: 28, fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: () async {
            if (selectedDate != null) {
              if (controller.noReserveDate.contains(selectedDate.toString())) {
                controller.noReserveDate.remove(selectedDate.toString());
              } else {
                controller.noReserveDate.add(selectedDate.toString());
              }
              debugPrint('noReserveDate : ${controller.noReserveDate}');
            }

            // upsert : true 없으면 만들고 있으면 덮어씀 파베에서 set
            final WriteResult? result =
                await QuizAppDatabaseService.I.getConnection()?.collection('noReserveDate').updateOne(
                      where.eq('_id', 'noReserveDate'),
                      modify.set('noReserveDate', controller.noReserveDate),
                      upsert: true,
                    );
            // 이게 가능한 이유는 RxList -> List -> Iterable 이런식으로 되기 때문이다
            controller.noReserveDate.value = List.from(controller.noReserveDate);
            debugPrint('result : ${result!.document.toString()}');
          },
          child: Text('예약 불가 설정'),
        ),
      ],
    );
  }
}

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
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
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

class ReserveCard extends StatelessWidget {
  final DateTime date;
  final String hour;

  const ReserveCard({
    super.key,
    required this.date,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: 10.h,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // 내부 채우기 색깔을 #FFFFFF로 설정
        borderRadius: BorderRadius.circular(10), // 테두리를 둥글게 만듦
        border: Border.all(
          color: Color(0xFFEEEEEE), // 테두리 색깔을 #EEEEEE로 설정
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 15,
            color: Color(0xFFBDBDBD),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${date.year}' +
                    "questionScreen_year".tr +
                    ' ${date.month}' +
                    "questionScreen_month".tr +
                    ' ${date.day}' +
                    "questionScreen_day".tr +
                    ' $hour',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E1F27),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "questionScreen_consult_30m".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF626262),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox(height: 10)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(RoutesConstants.consultCallScreen,
                      arguments: ConsultCallScreenArgs(date: date, hour: hour));
                },
                icon: Icon(Icons.arrow_forward_ios_outlined, size: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
