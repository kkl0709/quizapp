import 'package:chinesequizapp/Screens/HomeScreens/controller/quiz_result_controller.dart';
import 'package:chinesequizapp/Screens/HomeScreens/views/view_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/smtp_server.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../../infrastructure/Constants/route_constants.dart';

class QuizResultScreen extends GetView<QuizResultController> {
  QuizResultScreen({Key? key}) : super(key: key);

  final smtpServer = gmail('bagmunsu21@gmail.com', 'tmtmdsla6!');
  //박문수님 이메일 계정 연동

  void sendEmail() async {
    // 이메일 전
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
                SizedBox(width: 4.0),
                HeadlineBodyOneBaseWidget(
                  title: "common_button_back".tr,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  titleColor: AppConstantsColor.titleColor,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              HeadlineBodyOneBaseWidget(
                title: "quizResultScreen_title".tr,
                fontSize: 24.0,
                titleTextAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                titleColor: AppConstantsColor.titleColor,
              ),
              SizedBox(height: 10.0),
              HeadlineBodyOneBaseWidget(
                title: "quizResultScreen_content".tr,
                titleTextAlign: TextAlign.center,
                fontSize: 16.0,
                titleColor: AppConstantsColor.titleColor,
              ),
            ],
          ),
          Container(
            color: AppConstantsColor.disableButtonTextColor.withOpacity(0.05),
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                getTextField(
                  controller: controller.textField1Controller.value,
                  focusNode: controller.textField1focusNode.value,
                  title: "quizResultScreen_textField_title1".tr,
                  hintText: "quizResultScreen_textField_title1".tr,
                ),
                SizedBox(height: 24.0),
                getTextField(
                  controller: controller.textField2Controller.value,
                  focusNode: controller.textField2focusNode.value,
                  title: "quizResultScreen_textField_title2".tr,
                  hintText: "quizResultScreen_textField_title2".tr,
                ),
                SizedBox(height: 24.0),
                getTextField(
                  controller: controller.textField3Controller.value,
                  focusNode: controller.textField3focusNode.value,
                  title: "quizResultScreen_textField_title3".tr,
                  hintText: "quizResultScreen_textField_title3".tr,
                ),
                SizedBox(height: 24.0),
                getTextField(
                  controller: controller.textField4Controller.value,
                  focusNode: controller.textField4focusNode.value,
                  title: "quizResultScreen_textField_title4".tr,
                  hintText: "quizResultScreen_textField_title4".tr,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.textField1Controller.value.text.isNotEmpty &&
                  controller.textField2Controller.value.text.isNotEmpty &&
                  controller.textField3Controller.value.text.isNotEmpty &&
                  controller.textField4Controller.value.text.isNotEmpty) {
                Get.toNamed(RoutesConstants.viewResultScreen,
                    arguments: ViewResultArgs(
                      sub: controller.sub,
                      get: controller.textField1Controller.value.text,
                      give: controller.textField2Controller.value.text,
                      donGet: controller.textField3Controller.value.text,
                      donGive: controller.textField4Controller.value.text,
                    ));
              } else {}
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppConstantsColor.buttonColor,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.3),
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                    blurRadius: 5,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: HeadlineBodyOneBaseWidget(
                title: "quizResultScreen_button_result".tr,
                titleColor: AppConstantsColor.whiteColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? hintText,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Row(
        children: [
          Expanded(
            child: HeadlineBodyOneBaseWidget(
              title: title,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              titleTextAlign: TextAlign.center,
              titleColor: AppConstantsColor.titleColor,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppConstantsColor.disableButtonTextColor,
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
