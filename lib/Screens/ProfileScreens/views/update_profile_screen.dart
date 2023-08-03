import 'package:chinesequizapp/Screens/ProfileScreens/controller/profile_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../Behaviour/behaviour.dart';

class UpdateProfileScreen extends GetView<ProfileScreenController> {
  const UpdateProfileScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 32.0),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Container(
                      height: controller.isClickOnField.value
                          ? MediaQuery.of(context).size.height / 1.25
                          : MediaQuery.of(context).size.height / 1.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadlineBodyOneBaseWidget(
                                title: "updateProfileScreen_birth".tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                titleColor: AppConstantsColor.titleColor,
                              ),
                              const SizedBox(height: 4),
                              TextField(
                                controller:
                                    controller.textField1Controller.value,
                                focusNode: controller.textField1FocusNode.value,
                                cursorColor: AppConstantsColor.basicColor,
                                keyboardType: TextInputType.number,
                                maxLength: 8,
                                decoration: InputDecoration(
                                  hintText: "updateProfileScreen_birth".tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  counterText: "",
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
                                  if (value.isEmpty || value.length != 8) {
                                    controller.birthdayErrorMsg.value =
                                        "생년월일 8자리를 입력해주세요.";
                                  } else {
                                    controller.birthdayErrorMsg.value = "";
                                  }
                                },
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: HeadlineBodyOneBaseWidget(
                              title: "${controller.birthdayErrorMsg.value}",
                              fontSize: 14.0,
                              titleColor: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadlineBodyOneBaseWidget(
                                title: "updateProfileScreen_email".tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                titleColor: AppConstantsColor.titleColor,
                              ),
                              const SizedBox(height: 4),
                              TextField(
                                controller:
                                    controller.textField2Controller.value,
                                focusNode: controller.textField2FocusNode.value,
                                cursorColor: AppConstantsColor.basicColor,
                                decoration: InputDecoration(
                                  hintText: "updateProfileScreen_email".tr,
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
                                  controller.isLabel2.value = true;
                                  if (controller.textField1Controller.value.text
                                      .isEmpty) {
                                    controller.isLabel1.value = false;
                                  } else {
                                    controller.isLabel1.value = true;
                                  }
                                },
                                onSubmitted: (value) {
                                  controller.isClickOnField.value = false;
                                  if (controller.textField1Controller.value.text
                                      .isEmpty) {
                                    controller.isLabel2.value = false;
                                  } else {
                                    controller.isLabel2.value = true;
                                  }
                                },
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    controller.emailErrorMsg.value =
                                        "이메일 주소를 입력하십시오.";
                                    // controller.errorInt.value = 1;
                                  } else if (!value.isEmail) {
                                    controller.emailErrorMsg.value =
                                        "이메일 주소 형식을 확인해주세요.";
                                    // controller.errorInt.value = 1;
                                    // if (value ==
                                    //     controller
                                    //         .textField2Controller.value.text) {
                                    //   controller.errorInt.value = 0;
                                    // } else {
                                    //   controller.errorString.value =
                                    //       "정확한 비밀번호를 입력해주세요.";
                                    //   controller.errorInt.value = 1;
                                    // }
                                  } else {
                                    controller.emailErrorMsg.value = "";
                                    // controller.errorInt.value = 0;
                                  }
                                  //  if (value == null || value.isEmpty) {
                                  //       return "이메일 주소를 입력하십시오.";
                                  //     }
                                  //     if (!value.isEmail) {
                                  //       return "올바른 이메일 주소를 입력해주세요.";
                                  //     }
                                  //     if (controller.emailTextFieldError.value
                                  //         .isNotEmpty) {
                                  //       return controller
                                  //           .emailTextFieldError.value;
                                  //     }
                                },
                              ),
                              // Padding(Text(controller.emailErrorMsg.value, s))
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: HeadlineBodyOneBaseWidget(
                                  title: "${controller.emailErrorMsg.value}",
                                  fontSize: 14.0,
                                  titleColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          GestureDetector(
                            onTap: () {
                              controller.passwordChange();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppConstantsColor.buttonColor,
                                    borderRadius: BorderRadius.circular(12.0)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.0),
                                child: Center(
                                  child: HeadlineBodyOneBaseWidget(
                                    title: "updateProfileScreen_password".tr,
                                    titleColor:
                                        AppConstantsColor.buttonTextColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          GestureDetector(
                            onTap: () => Get.toNamed(RoutesConstants.profileEdit),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 60),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppConstantsColor.buttonColor,
                                    borderRadius: BorderRadius.circular(12.0)),
                                padding:
                                const EdgeInsets.symmetric(vertical: 14.0),
                                child: Center(
                                  child: HeadlineBodyOneBaseWidget(
                                    title: '프로필 수정',
                                    titleColor:
                                    AppConstantsColor.buttonTextColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          controller.isKeyboardOpen.value
                              ? SizedBox(
                                  height: 100.0,
                                )
                              : Spacer(),
                          GestureDetector(
                            onTap: (controller.emailErrorMsg.isNotEmpty ||
                                    controller.birthdayErrorMsg.isNotEmpty)
                                ? null
                                : () async {
                                    // if (controller.textField2Controller.value
                                    //     .text.isNotEmpty) {
                                    //   controller.textField2Controller;
                                    //   Get.offAllNamed(
                                    //       RoutesConstants.homeScreen);
                                    // }
                                    bool ret = await controller.onSubmit();
                                    if (ret) {
                                      final int code =
                                          await SharedPreferenceService
                                              .getAuthCode;
                                      await SharedPreferenceService
                                          .saveLoggedIn(
                                              true,
                                              controller.textField2Controller
                                                  .value.text,
                                              code);
                                      controller.refreshState();
                                      Get.back();
                                    } else {}
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      !(controller.emailErrorMsg.isNotEmpty ||
                                              controller
                                                  .birthdayErrorMsg.isNotEmpty)
                                          ? AppConstantsColor.basicColor
                                          : AppConstantsColor.normalTextColor
                                              .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.0)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                              child: Center(
                                child: HeadlineBodyOneBaseWidget(
                                  title: "updateProfileScreen_button_done".tr,
                                  titleColor:
                                      !(controller.emailErrorMsg.isNotEmpty ||
                                              controller
                                                  .birthdayErrorMsg.isNotEmpty)
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
