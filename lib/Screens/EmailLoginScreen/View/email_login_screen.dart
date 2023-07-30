import 'package:chinesequizapp/infrastructure/Constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../Behaviour/behaviour.dart';
import '../Controller/email_login_controller.dart';

class EmailLoginScreen extends GetView<EmailLoginController> {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppConstantsColor.buttonTextColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.platformSelectImage,
                      height: 95,
                      width: 95,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "emailLoginScreen_title".tr,
                      titleColor: AppConstantsColor.labelTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "emailLoginScreen_content".tr,
                      titleColor: AppConstantsColor.normalTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.isLabel1.value
                            ? HeadlineBodyOneBaseWidget(
                                title: "emailLoginScreen_email".tr,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              )
                            : Container(),
                        const SizedBox(height: 4),
                        TextField(
                          controller: controller.textField1Controller.value,
                          cursorColor: AppConstantsColor.basicColor,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "emailLoginScreen_email".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: controller.emailErrorInt == 1
                                    ? Colors.red
                                    : AppConstantsColor.basicColor,
                                width: 2,
                              ),
                            ),
                            errorText: controller.emailErrorInt == 1
                                ? controller.emailErrorString.value
                                : null,
                          ),
                          onTap: () {
                            controller.isLabel1.value = true;
                            if (controller
                                .textField2Controller.value.text.isEmpty) {
                              controller.isLabel2.value = false;
                            } else {
                              controller.isLabel2.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            if (controller
                                .textField1Controller.value.text.isEmpty) {
                              controller.isLabel1.value = false;
                            } else {
                              controller.isLabel1.value = true;
                            }
                          },
                          onChanged: (value) {
                            if (controller
                                .textField1Controller.value.text.isNotEmpty) {
                              print("Text Field Length : ${value.length}");

                              if (value.isEmail) {
                                controller.emailErrorInt.value = 0;
                              } else {
                                controller.emailErrorString.value =
                                    "유효한 이메일 아이디를 입력하세요.";
                                controller.emailErrorInt.value = 1;
                              }
                            } else {
                              controller.emailErrorInt.value = 2;
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.isLabel2.value
                            ? HeadlineBodyOneBaseWidget(
                                title: "emailLoginScreen_password".tr,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              )
                            : Container(),
                        const SizedBox(height: 4),
                        TextField(
                          controller: controller.textField2Controller.value,
                          cursorColor: AppConstantsColor.basicColor,
                          obscureText: !controller.showPassword.value,
                          decoration: InputDecoration(
                            hintText: "emailLoginScreen_password".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: controller.errorInt == 1
                                    ? Colors.red
                                    : AppConstantsColor.basicColor,
                                width: 2,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.showPassword.value =
                                    controller.showPassword.value == true
                                        ? false
                                        : true;
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                child: Image.asset(
                                  !controller.showPassword.value
                                      ? ImageConstants.hidePasswordImage
                                      : ImageConstants.showPasswordImage,
                                  color: AppConstantsColor.titleColor
                                      .withOpacity(0.6),
                                  height: 10.0,
                                  width: 10.0,
                                ),
                              ),
                            ),
                            errorText: controller.errorInt == 1
                                ? controller.errorString.value
                                : null,
                          ),
                          onTap: () {
                            controller.isClickOnField.value = true;
                            controller.isLabel2.value = true;
                            if (controller
                                .textField1Controller.value.text.isEmpty) {
                              controller.isLabel1.value = false;
                            } else {
                              controller.isLabel1.value = true;
                            }
                          },
                          onSubmitted: (value) {
                            controller.isClickOnField.value = false;
                            if (controller
                                .textField2Controller.value.text.isEmpty) {
                              controller.isLabel2.value = false;
                            } else {
                              controller.isLabel2.value = true;
                            }
                          },
                          onChanged: (value) {
                            if (controller
                                .textField2Controller.value.text.isNotEmpty) {
                              print("Text Field Length : ${value.length}");

                              if (value.length >= 8) {
                                controller.errorInt.value = 0;
                              } else {
                                controller.errorString.value =
                                    "비밀번호는 8자 이상이어야 합니다.";
                                controller.errorInt.value = 1;
                              }
                            } else {
                              controller.errorInt.value = 2;
                            }
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.emailErrorInt.value == 0 &&
                                controller.errorInt.value == 0) {
                              controller.login();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.emailErrorInt.value == 0 &&
                                        controller.errorInt.value == 0
                                    ? AppConstantsColor.basicColor
                                    : AppConstantsColor.normalTextColor
                                        .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.0)),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            child: Center(
                              child: HeadlineBodyOneBaseWidget(
                                title: "emailLoginScreen_button_login".tr,
                                titleColor:
                                    controller.emailErrorInt.value == 0 &&
                                            controller.errorInt.value == 0
                                        ? AppConstantsColor.buttonTextColor
                                        : AppConstantsColor.normalTextColor
                                            .withOpacity(0.5),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector selectPlatform(
      {required BuildContext context,
      required String platformImage,
      required Function() onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Image.asset(
        platformImage,
        height: 50.0,
        width: 50.0,
      ),
    );
  }
}
