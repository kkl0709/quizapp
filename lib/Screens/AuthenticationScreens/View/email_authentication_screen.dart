import 'package:chinesequizapp/Screens/Behaviour/behaviour.dart';
import 'package:chinesequizapp/infrastructure/Constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../Controller/email_authentication_controller.dart';

class EmailVerification extends GetView<EmailVerificationController> {
  const EmailVerification({Key? key}) : super(key: key);

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
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Center(
                      child: Image.asset(
                        ImageConstants.emailVerificationImage,
                        height: 115,
                        width: 115,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "emailAuthenticationScreen_title".tr,
                      titleColor: AppConstantsColor.labelTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "emailAuthenticationScreen_content".tr,
                      titleColor:
                          AppConstantsColor.normalTextColor.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                    Spacer(),
                    controller.isLabel1.value
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: HeadlineBodyOneBaseWidget(
                              title: "emailAuthenticationScreen_email".tr,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller.textField1Controller.value,
                      cursorColor: AppConstantsColor.basicColor,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "emailAuthenticationScreen_emailInput".tr,
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
                        controller.isLabel1.value = true;
                      },
                      onChanged: (value) {
                        if (controller
                            .textField1Controller.value.text.isNotEmpty) {
                          print("Text Field Length : ${value.length}");

                          if (value.isEmail) {
                            controller.errorInt.value = 0;
                          } else {
                            controller.errorString.value =
                                "유효한 이메일 아이디를 입력하세요.";
                            controller.errorInt.value = 1;
                          }
                        } else {
                          controller.errorInt.value = 2;
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.errorInt.value == 0) {
                          // Get.toNamed(RoutesConstants.otpVerificationScreen);
                          controller.onTapNext();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller
                                    .textField1Controller.value.text.isEmail
                                ? AppConstantsColor.basicColor
                                : AppConstantsColor.normalTextColor
                                    .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0)),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Center(
                          child: HeadlineBodyOneBaseWidget(
                            title: "emailAuthenticationScreen_button_next".tr,
                            titleColor: controller
                                    .textField1Controller.value.text.isEmail
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
      ),
    );
  }
}
