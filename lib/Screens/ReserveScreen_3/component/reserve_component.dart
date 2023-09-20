import 'package:chinesequizapp/Screens/ProfileScreens/controller/profile_screen_controller.dart';
import 'package:chinesequizapp/Screens/QuestionScreen/views/consult_call_screen.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/controller/reserve_controller.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/model/reserve_model.dart';
import 'package:chinesequizapp/infrastructure/Constants/database_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ManageReserve extends StatelessWidget {
  final DateTime? selectedDate;
  final ReserveController controller;

  const ManageReserve({
    super.key,
    required this.selectedDate,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "questionScreen_consultTimeReserve".tr,
            style: TextStyle(color: Color(0xFF1E1F27), fontSize: 28, fontWeight: FontWeight.w700),
            overflow: TextOverflow.clip,
            //maxLines: 2,
          ),
        ),
        if(Utils.userModel.isAdmin)
        TextButton(
          onPressed: () async {
            if (DatabaseConstants.noReserveDates.isNotEmpty) {
              debugPrint('2');
              if (!DatabaseConstants.noReserveDates.contains(controller.selectedDate.value.toString())) {
                await FirebaseFirestore.instance
                    .collection('reserve')
                    .doc(DateTime(1990, 01, 01).toString())
                    .update({
                  'noReserveDate': FieldValue.arrayUnion([controller.selectedDate.value.toString()])
                });
              } else {
                debugPrint('3');
                await FirebaseFirestore.instance
                    .collection('reserve')
                    .doc(DateTime(1990, 01, 01).toString())
                    .update({
                  'noReserveDate': FieldValue.arrayRemove([controller.selectedDate.value.toString()])
                });
              }
            } else {
              await FirebaseFirestore.instance
                  .collection('reserve')
                  .doc(DateTime(1990, 01, 01).toString())
                  .set(
                    ReserveModel(
                            date: Timestamp.fromDate(DateTime(1990, 01, 01)),
                            userEmail: '관리자',
                            status: '휴무일',
                            noReserveDate: [controller.selectedDate.value.toString()],
                            phoneNumber: '0')
                        .toJson(),
                  );
            }
          },
          child: Text('예약 불가일 설정'),
        ),
      ],
    );
  }
}

class ReserveCard extends StatelessWidget {
  final DateTime date;
  final ReserveModel reserveModel;

  const ReserveCard({
    super.key,
    required this.date,
    required this.reserveModel,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileScreenController>();
    if (reserveModel.status == '휴무일') {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      height: 15.h,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // 내부 채우기 색깔을 #FFFFFF로 설정
        borderRadius: BorderRadius.circular(10), // 테두리를 둥글게 만듦
        border: Border.all(
          color: Color(0xFFEEEEEE), // 테두리 색깔을 #EEEEEE로 설정
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 15,
            color: Color(0xFFBDBDBD),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${date.year}' +
                      "questionScreen_year".tr +
                      ' ${date.month}' +
                      "questionScreen_month".tr +
                      ' ${date.day}' +
                      "questionScreen_day".tr +
                      ' ${date.hour.toString().padLeft(2, '0')}' +
                      ':${date.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E1F27),
                    fontSize: 14,
                  ),
                  maxLines: 6,
                ),
                SizedBox(height: 10),
                Text(
                  "questionScreen_consult_30m".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF626262),
                  ),
                  maxLines: 6,
                ),
              ],
            ),
          ),
          /* 예약 불가 or 예약자 이름 */
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                decoration: BoxDecoration(
                  color: reserveModel.status == '예약가능'
                      ? Colors.blue.withOpacity(0.5)
                      : reserveModel.status == '예약완료'
                          ? Colors.green.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5), // 검정색 배경
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (reserveModel.status != '예약완료')
                        Text(
                          reserveModel.status == "예약불가"
                              ? "reserveScreen_impossible".tr
                              : "reserveScreen_possible".tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                        ),
                      if (reserveModel.status == '예약완료')
                        GestureDetector(
                          onTap: () async {
                            if (reserveModel.userEmail == profileController.account.value.email) {
                              await FirebaseFirestore.instance
                                  .collection('reserve')
                                  .doc(date.toString())
                                  .update(reserveModel.copyWith(
                                    status: '예약가능',
                                    userEmail: 'initialEmail',
                                    phoneNumber: '0',
                                    noReserveDate: [],
                                  ).toJson());
                            }
                          },
                          child: Column(
                            children: [
                              Text(
                                reserveModel.userEmail,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              if (Utils.userModel.isAdmin)
                                Text(
                                  reserveModel.phoneNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          /* 관리자 예약 불가 시간 설정 / 취소 설정 */
          if (Utils.userModel.isAdmin && reserveModel.status != '예약완료')
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      if (reserveModel.status != '예약불가') {
                        await FirebaseFirestore.instance.collection('reserve').doc(date.toString()).set(
                              reserveModel
                                  .copyWith(
                                    date: Timestamp.fromDate(date),
                                    status: '예약불가',
                                    userEmail: profileController.account.value.email,
                                  )
                                  .toJson(),
                            );
                      } else {
                        await FirebaseFirestore.instance.collection('reserve').doc(date.toString()).set(
                              reserveModel
                                  .copyWith(
                                    date: Timestamp.fromDate(date),
                                    status: '예약가능',
                                    userEmail: profileController.account.value.email,
                                  )
                                  .toJson(),
                            );
                      }
                    },
                    child: Icon(Icons.free_cancellation_outlined, size: 25))
              ],
            ),
          /* 사용자 예약 설정, 취소 */
          if (reserveModel.status == '예약가능' && !Utils.userModel.isAdmin)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        Get.toNamed(
                          RoutesConstants.consultCallScreen,
                          arguments: ConsultCallScreenArgs(date: date, reserveModel: reserveModel),
                        );
                      },
                      child: Icon(Icons.arrow_forward_ios_outlined, size: 14))
                ],
              ),
            )
        ],
      ),
    );
  }
}
