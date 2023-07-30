import 'package:chinesequizapp/Screens/AuthenticationScreens/Controller/password_authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../../infrastructure/Constants/route_constants.dart';
import '../../Behaviour/behaviour.dart';

class PasswordVerificationScreenArgs {
  final String email;
  const PasswordVerificationScreenArgs({required this.email});
}

class PasswordVerificationScreen
    extends GetView<PasswordVerificationController> {
  const PasswordVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppConstantsColor.buttonTextColor,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              HeadlineBodyOneBaseWidget(
                title: "passwordAuthenticationScreen_title".tr,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                titleColor: AppConstantsColor.basicColor,
              ),
              const SizedBox(height: 10.0),
              HeadlineBodyOneBaseWidget(
                title: "passwordAuthenticationScreen_content".tr,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                titleColor: AppConstantsColor.normalTextColor.withOpacity(0.5),
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Container(
                      height: controller.isClickOnField.value
                          ? MediaQuery.of(context).size.height / 1.4
                          : MediaQuery.of(context).size.height / 1.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.isLabel1.value
                                  ? HeadlineBodyOneBaseWidget(
                                      title:
                                          "passwordAuthenticationScreen_password"
                                              .tr,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    )
                                  : Container(),
                              const SizedBox(height: 4),
                              TextField(
                                controller:
                                    controller.textField1Controller.value,
                                focusNode: controller.textField1FocusNode.value,
                                cursorColor: AppConstantsColor.basicColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText:
                                      "passwordAuthenticationScreen_password"
                                          .tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: AppConstantsColor.basicColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  controller.isClickOnField.value = true;
                                  controller.isLabel1.value = true;
                                  if (controller.textField2Controller.value.text
                                      .isEmpty) {
                                    controller.isLabel2.value = false;
                                  } else {
                                    controller.isLabel2.value = true;
                                  }
                                },
                                onSubmitted: (value) {
                                  controller.isClickOnField.value = false;
                                  if (controller.textField1Controller.value.text
                                      .isEmpty) {
                                    controller.isLabel1.value = false;
                                  } else {
                                    controller.isLabel1.value = true;
                                  }
                                },
                                onChanged: (value) {
                                  if (controller.textField2Controller.value.text
                                      .isNotEmpty) {
                                    if (value !=
                                        controller
                                            .textField2Controller.value.text) {
                                      controller.errorString.value =
                                          "정확한 비밀번호를 입력해주세요.";
                                      controller.errorInt.value = 1;
                                    } else if (value.length < 8) {
                                      controller.errorString.value =
                                          "비밀번호는 8자 이상이어야 합니다.";
                                      controller.errorInt.value = 1;
                                    } else {
                                      controller.errorInt.value = 0;
                                    }
                                  } else {
                                    controller.errorInt.value = 0;
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.isLabel2.value
                                  ? HeadlineBodyOneBaseWidget(
                                      title:
                                          "passwordAuthenticationScreen_passwordCheck"
                                              .tr,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    )
                                  : Container(),
                              const SizedBox(height: 4),
                              TextField(
                                controller:
                                    controller.textField2Controller.value,
                                focusNode: controller.textField2FocusNode.value,
                                cursorColor: AppConstantsColor.basicColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText:
                                      "passwordAuthenticationScreen_passwordCheck"
                                          .tr,
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
                                  errorText: controller.errorInt == 1
                                      ? controller.errorString.value
                                      : null,
                                ),
                                onTap: () {
                                  controller.isClickOnField.value = true;
                                  controller.isLabel2.value = true;
                                  if (controller.textField1Controller.value.text
                                      .isEmpty) {
                                    controller.isLabel1.value = false;
                                  } else {
                                    controller.isLabel1.value = true;
                                  }
                                },
                                onChanged: (value) {
                                  if (value ==
                                      controller
                                          .textField1Controller.value.text) {
                                    controller.errorInt.value = 0;
                                  } else {
                                    controller.errorString.value =
                                        "정확한 비밀번호를 입력해주세요.";
                                    controller.errorInt.value = 1;
                                  }
                                  if (value !=
                                      controller
                                          .textField1Controller.value.text) {
                                    controller.errorString.value =
                                        "정확한 비밀번호를 입력해주세요.";
                                    controller.errorInt.value = 1;
                                  } else if (value.length < 8) {
                                    controller.errorString.value =
                                        "비밀번호는 8자 이상이어야 합니다.";
                                    controller.errorInt.value = 1;
                                  } else {
                                    controller.errorInt.value = 0;
                                  }
                                },
                                onSubmitted: (value) {
                                  controller.isClickOnField.value = false;
                                  if (controller.textField2Controller.value.text
                                      .isEmpty) {
                                    controller.isLabel2.value = false;
                                  } else {
                                    controller.isLabel2.value = true;
                                  }
                                  if (controller.textField2Controller.value.text
                                      .isEmpty) {
                                    controller.errorInt.value = 0;
                                  }
                                },
                              ),
                            ],
                          ),
                          controller.isKeyboardOpen.value
                              ? SizedBox(
                                  height: 60.0,
                                )
                              : Spacer(),
                          GestureDetector(
                            onTap: () async {
                              if (controller.textField2Controller.value.text
                                      .isNotEmpty &&
                                  controller.errorInt.value == 0) {
                                final bool ret =
                                    await controller.resetPassword();
                                if (ret) {
                                  Fluttertoast.showToast(
                                      msg: "비밀번호가 변경되었습니다. 다시 로그인해주세요.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.transparent,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Get.offAllNamed(RoutesConstants.onBoarding);
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: controller.textField2Controller.value
                                              .text.isNotEmpty &&
                                          controller.errorInt.value == 0
                                      ? AppConstantsColor.basicColor
                                      : AppConstantsColor.normalTextColor
                                          .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.0)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              child: Center(
                                child: HeadlineBodyOneBaseWidget(
                                  title:
                                      "passwordAuthenticationScreen_button_done"
                                          .tr,
                                  titleColor: controller.textField2Controller
                                              .value.text.isNotEmpty &&
                                          controller.errorInt.value == 0
                                      ? AppConstantsColor.buttonTextColor
                                      : AppConstantsColor.normalTextColor
                                          .withOpacity(0.5),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
