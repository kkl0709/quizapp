import 'package:chinesequizapp/Screens/ProfileScreens/controller/profile_screen_controller.dart';
import 'package:chinesequizapp/Screens/QuestionScreen/controller/consult_call_controller.dart';
import 'package:chinesequizapp/Screens/ReserveScreen_3/model/reserve_model.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/components/form_input_text.dart';
import 'package:chinesequizapp/infrastructure/models/consult.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultCallScreenArgs {
  final DateTime date;
  final ReserveModel reserveModel;

  const ConsultCallScreenArgs({
    required this.date,
    required this.reserveModel,
  });
}

class ConsultCallScreen extends GetView<ConsultCallController> {
  ConsultCallScreen({super.key});

  int previousLength = 0;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileScreenController());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "questionScreen_consult_phone_number".tr,
                style: TextStyle(
                  color: Color(0xFF1E1F27),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              FormInputText(
                hintText: '010-1234-5678',
                controller: controller.phoneTEC.value,
                onChanged: (value) {
                  if (value.length < previousLength) {
                    // 지우는 동작이므로 '-' 문자 추가 로직을 실행하지 않음
                    controller.tecChanged();
                  } else {
                    if (controller.phoneTEC.value.text.length == 3 ||
                        controller.phoneTEC.value.text.length == 8) {
                      controller.phoneTEC.value.text += '-';
                      controller.phoneTEC.value.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.phoneTEC.value.text.length));
                    }
                    controller.tecChanged();
                  }
                  previousLength = value.length; // 현재의 길이를 저장
                },
                keyboardType: TextInputType.number,
              ),
              Expanded(child: SizedBox()),
              GetBuilder<ConsultCallController>(
                builder: (controller) => ElevatedButton(
                  onPressed: controller.phoneTEC.value.text.isEmpty
                      ? null
                      : () async {
                          await FirebaseFirestore.instance
                              .collection('reserve')
                              .doc(controller.date.toString())
                              .set(
                                ReserveModel(
                                  date: Timestamp.fromDate(controller.date),
                                  userEmail: profileController.account.value.email!,
                                  status: '예약완료',
                                  noReserveDate: [],
                                  phoneNumber: controller.phoneTEC.value.text,
                                ).toJson(),
                              );
                          final consultModel = ConsultModel(
                            phoneNumber: controller.phoneTEC.value.text,
                            date: controller.date,
                          );
                          await QuizAppDatabaseService.I
                              .getConnection()
                              ?.collection('noReserveDate')
                              .insertOne(consultModel.toJson());
                          Get.offAllNamed(RoutesConstants.homeScreen); // 모든 스택을 제거하고 HomeScreen으로 이동
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(10, 52),
                    backgroundColor: Color(0xFF321646), // 버튼색을 #321646로 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 버튼 모서리를 둥글게 설정
                    ),
                  ),
                  child: Text(
                    "questionScreen_next".tr,
                    style: TextStyle(
                      color: Colors.white, // 글자색을 흰색으로 설정
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
