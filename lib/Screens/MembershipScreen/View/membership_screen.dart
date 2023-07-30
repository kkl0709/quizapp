import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../Behaviour/behaviour.dart';
import '../Controller/membership_controller.dart';

class MembershipScreen extends GetView<MembershipController> {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
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
                title: "membershipScreen_signUp".tr,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                titleColor: AppConstantsColor.basicColor,
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.isLabel1.value
                                      ? HeadlineBodyOneBaseWidget(
                                          title: "membershipScreen_email".tr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        )
                                      : Container(),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller:
                                        controller.textField1Controller.value,
                                    focusNode:
                                        controller.textField1FocusNode.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "이메일 주소를 입력하십시오.";
                                      }
                                      if (!value.isEmail) {
                                        return "올바른 이메일 주소를 입력해주세요.";
                                      }
                                      if (controller.emailTextFieldError.value
                                          .isNotEmpty) {
                                        return controller
                                            .emailTextFieldError.value;
                                      }
                                      return null;
                                    },
                                    cursorColor: AppConstantsColor.basicColor,
                                    decoration: InputDecoration(
                                      hintText: "membershipScreen_email".tr,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppConstantsColor.basicColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.isEmpty) {
                                        controller.isLabel1.value = false;
                                      }
                                    },
                                    onTap: () {
                                      controller.isLabel1.value = true;
                                      if (controller.textField2Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel2.value = false;
                                      } else {
                                        controller.isLabel2.value = true;
                                      }
                                      if (controller.textField3Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel3.value = false;
                                      } else {
                                        controller.isLabel3.value = true;
                                      }
                                      if (controller.textField4Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel4.value = false;
                                      } else {
                                        controller.isLabel4.value = true;
                                      }
                                      if (controller.textField5Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel5.value = false;
                                      } else {
                                        controller.isLabel5.value = true;
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
                                          title: "membershipScreen_password".tr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        )
                                      : Container(),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller:
                                        controller.textField2Controller.value,
                                    focusNode:
                                        controller.textField2FocusNode.value,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "비밀번호를 입력 해주세요";
                                      } else if (value.length < 8) {
                                        return "비밀번호는 8자 이상이어야 합니다";
                                      }
                                      return null;
                                    },
                                    cursorColor: AppConstantsColor.basicColor,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "membershipScreen_password".tr,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppConstantsColor.basicColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.isEmpty) {
                                        controller.isLabel2.value = false;
                                      }
                                    },
                                    onTap: () {
                                      controller.isLabel2.value = true;
                                      if (controller.textField1Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel1.value = false;
                                      } else {
                                        controller.isLabel1.value = true;
                                      }
                                      if (controller.textField3Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel3.value = false;
                                      } else {
                                        controller.isLabel3.value = true;
                                      }
                                      if (controller.textField4Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel4.value = false;
                                      } else {
                                        controller.isLabel4.value = true;
                                      }
                                      if (controller.textField5Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel5.value = false;
                                      } else {
                                        controller.isLabel5.value = true;
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
                                  controller.isLabel3.value
                                      ? HeadlineBodyOneBaseWidget(
                                          title:
                                              "membershipScreen_passwordCheck"
                                                  .tr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        )
                                      : Container(),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller:
                                        controller.textField3Controller.value,
                                    focusNode:
                                        controller.textField3FocusNode.value,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "비밀번호를 입력 해주세요";
                                      } else if (controller.textField2Controller
                                              .value.text !=
                                          controller.textField3Controller.value
                                              .text) {
                                        return "비밀번호가 일치하지 않습니다";
                                      }
                                      return null;
                                    },
                                    cursorColor: AppConstantsColor.basicColor,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText:
                                          "membershipScreen_passwordCheck".tr,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      suffixIcon: controller.isLabel3.value
                                          ? InkWell(
                                              onTap: () {
                                                controller.textField3Controller
                                                    .value.text = "";
                                                controller.isLabel3.value =
                                                    false;
                                              },
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Transform.rotate(
                                                  angle: 3.14 / 4,
                                                  child: Icon(
                                                    Icons.add_circle_outlined,
                                                    color: AppConstantsColor
                                                        .disableButtonTextColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : null,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppConstantsColor.basicColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.isEmpty) {
                                        controller.isLabel3.value = false;
                                      }
                                    },
                                    onTap: () {
                                      controller.isLabel3.value = true;
                                      print(
                                          "object : ${controller.textField2Controller.value.text.isEmpty}");
                                      if (controller.textField1Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel1.value = false;
                                      } else {
                                        controller.isLabel1.value = true;
                                      }
                                      if (controller.textField2Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel2.value = false;
                                      } else {
                                        controller.isLabel2.value = true;
                                      }
                                      if (controller.textField4Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel4.value = false;
                                      } else {
                                        controller.isLabel4.value = true;
                                      }
                                      if (controller.textField5Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel5.value = false;
                                      } else {
                                        controller.isLabel5.value = true;
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
                                  controller.isLabel4.value
                                      ? HeadlineBodyOneBaseWidget(
                                          title: "membershipScreen_name".tr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        )
                                      : Container(),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller:
                                        controller.textField4Controller.value,
                                    focusNode:
                                        controller.textField4FocusNode.value,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "이름을 입력하세요";
                                      }
                                      return null;
                                    },
                                    cursorColor: AppConstantsColor.basicColor,
                                    decoration: InputDecoration(
                                      hintText: "membershipScreen_name".tr,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppConstantsColor.basicColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.isEmpty) {
                                        controller.isLabel4.value = false;
                                      }
                                    },
                                    onTap: () {
                                      controller.isLabel4.value = true;
                                      if (controller.textField1Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel1.value = false;
                                      } else {
                                        controller.isLabel1.value = true;
                                      }
                                      if (controller.textField2Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel2.value = false;
                                      } else {
                                        controller.isLabel2.value = true;
                                      }
                                      if (controller.textField3Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel3.value = false;
                                      } else {
                                        controller.isLabel3.value = true;
                                      }
                                      if (controller.textField5Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel5.value = false;
                                      } else {
                                        controller.isLabel5.value = true;
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
                                  controller.isLabel5.value
                                      ? HeadlineBodyOneBaseWidget(
                                          title: "membershipScreen_birth".tr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                        )
                                      : Container(),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller:
                                        controller.textField5Controller.value,
                                    focusNode:
                                        controller.textField5FocusNode.value,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "생년월일을 입력해주세요";
                                      }
                                      if (value.length != 8) {
                                        return "8자리 생년월일을 확인해주세요.";
                                      }
                                      return null;
                                    },
                                    cursorColor: AppConstantsColor.basicColor,
                                    maxLength: 8,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "membershipScreen_birth".tr,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(
                                          color: AppConstantsColor.basicColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.isEmpty) {
                                        controller.isLabel5.value = false;
                                      }
                                    },
                                    onTap: () {
                                      controller.isLabel5.value = true;
                                      if (controller.textField1Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel1.value = false;
                                      } else {
                                        controller.isLabel1.value = true;
                                      }
                                      if (controller.textField2Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel2.value = false;
                                      } else {
                                        controller.isLabel2.value = true;
                                      }
                                      if (controller.textField3Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel3.value = false;
                                      } else {
                                        controller.isLabel3.value = true;
                                      }
                                      if (controller.textField4Controller.value
                                          .text.isEmpty) {
                                        controller.isLabel4.value = false;
                                      } else {
                                        controller.isLabel4.value = true;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                onTap: () {
                                  controller.gender.value = 0;
                                  print("Man : ${controller.gender.value}");
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controller.gender.value == 0
                                            ? AppConstantsColor.basicColor
                                            : AppConstantsColor
                                                .disableButtonTextColor,
                                        width: controller.gender.value == 0
                                            ? controller.gender.value == 3
                                                ? 1
                                                : 2
                                            : 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14.0,
                                  ),
                                  child: Center(
                                    child: HeadlineBodyOneBaseWidget(
                                      title: "membershipScreen_men".tr,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      titleColor: controller.gender.value == 0
                                          ? AppConstantsColor.basicColor
                                          : AppConstantsColor
                                              .disableButtonTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                onTap: () {
                                  controller.gender.value = 1;
                                  print("Female : ${controller.gender.value}");
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: controller.gender.value == 1
                                          ? AppConstantsColor.basicColor
                                          : AppConstantsColor
                                              .disableButtonTextColor,
                                      width: controller.gender.value == 1
                                          ? controller.gender.value == 3
                                              ? 1
                                              : 2
                                          : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0),
                                  child: Center(
                                    child: HeadlineBodyOneBaseWidget(
                                      title: "membershipScreen_women".tr,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      titleColor: controller.gender.value == 1
                                          ? AppConstantsColor.basicColor
                                          : AppConstantsColor
                                              .disableButtonTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        Divider(
                          color: AppConstantsColor.disableButtonTextColor,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(16.0),
                              onTap: () {
                                controller.isAcceptTermAndCondition.value =
                                    !controller.isAcceptTermAndCondition.value;
                              },
                              child: Icon(
                                controller.isAcceptTermAndCondition.value
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: controller.isAcceptTermAndCondition.value
                                    ? AppConstantsColor.basicColor
                                    : AppConstantsColor.disableButtonTextColor,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            HeadlineBodyOneBaseWidget(
                              title: "membershipScreen_terms".tr,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        HeadlineBodyOneBaseWidget(
                          title: "membershipScreen_termsAgree".tr,
                          fontSize: 16.0,
                        ),
                        const SizedBox(height: 24.0),
                        controller.isAcceptTermAndCondition.value
                            ? InkWell(
                                onTap: () async {
                                  await controller.validateAccount();
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    /// TODO:: KKM - 회원가입 onTap
                                    controller.createAccount();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppConstantsColor.basicColor,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0),
                                  child: Center(
                                    child: HeadlineBodyOneBaseWidget(
                                      title: "membershipScreen_register".tr,
                                      titleColor:
                                          AppConstantsColor.buttonTextColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(height: MediaQuery.of(context).padding.top),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
