import 'package:chinesequizapp/Screens/AuthenticationScreens/Controller/email_otp_veryfication_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/image_constants.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../Behaviour/behaviour.dart';

enum VerificationType {
  registration,
  passwordReset,
}

class EmailOTPVerificationArgs {
  final Account account;
  final String pinCode;
  final VerificationType type;

  const EmailOTPVerificationArgs({
    required this.account,
    required this.pinCode,
    required this.type,
  });
}

class EmailOTPVerification extends GetView<EmailOTPVerificationController> {
  const EmailOTPVerification();

  @override
  Widget build(BuildContext context) {
    // final EmailOTPVerificationArgs args = EmailOTPVerificationArgs;
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Center(
                        child: Image.asset(
                          ImageConstants.numberVerificationImage,
                          height: 115,
                          width: 115,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      HeadlineBodyOneBaseWidget(
                        title: "emailVerificationScreen_title".tr,
                        titleColor: AppConstantsColor.labelTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      HeadlineBodyOneBaseWidget(
                        title: "[${controller.account?.email}] 로 발송된",
                        titleColor:
                            AppConstantsColor.normalTextColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      HeadlineBodyOneBaseWidget(
                        title: "emailVerificationScreen_content".tr,
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
                                title: "emailVerificationScreen_code".tr,
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
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        inputFormatters: [],
                        decoration: InputDecoration(
                          hintText: "emailVerificationScreen_codeInput".tr,
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
                          controller.isLabel1.value = true;
                        },
                        onChanged: (value) {
                          if (controller.errorMessage.isNotEmpty) {
                            controller.errorMessage.value = '';
                          }
                          if (value.length == 6) {
                            controller.isButtonEnable.value = true;
                          } else {
                            controller.isButtonEnable.value = false;
                          }
                        },
                        onSubmitted: (_) => controller.onSubmitted(),
                      ),
                      Visibility(
                          visible: controller.errorMessage.value.isNotEmpty,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: HeadlineBodyOneBaseWidget(
                              title: controller.errorMessage.value,
                              titleTextAlign: TextAlign.left,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              titleColor: Colors.red,
                            ),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () => controller.onSubmitted(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: controller.isButtonEnable.value
                                  ? AppConstantsColor.basicColor
                                  : AppConstantsColor.normalTextColor
                                      .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.0)),
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Center(
                            child: HeadlineBodyOneBaseWidget(
                              title: controller.verificationType ==
                                      VerificationType.registration
                                  ? "emailVerificationScreen_button_next".tr
                                  : "emailVerificationScreen_button_next".tr,
                              titleColor: controller
                                      .textField1Controller.value.text.isEmail
                                  ? AppConstantsColor.buttonTextColor
                                  : AppConstantsColor.whiteColor,
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
      ),
    );
  }
}
