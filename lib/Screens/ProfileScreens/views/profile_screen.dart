import 'package:chinesequizapp/Screens/ProfileScreens/controller/profile_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/mixins/authentication_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    HeadlineBodyOneBaseWidget(
                      title: (controller.account.value.name ?? '').toString(),
                      titleTextAlign: TextAlign.center,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                      titleColor: AppConstantsColor.blackColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: controller.account.value.gender == null
                          ? ''
                          : controller.account.value.gender == 0
                              ? "profileScreen_men".tr
                              : "profileScreen_women".tr,
                      titleTextAlign: TextAlign.center,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      titleColor:
                          AppConstantsColor.normalTextColor.withOpacity(0.5),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () =>
                            Get.toNamed(RoutesConstants.updateProfileScreen),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppConstantsColor.normalTextColor
                                      .withOpacity(0.5),
                                  width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: HeadlineBodyOneBaseWidget(
                              title: "profileScreen_profileEdit".tr,
                              titleTextAlign: TextAlign.center,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              titleColor: AppConstantsColor.blackColor,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesConstants.updateProfileScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              9.0,
                              8.0,
                            ),
                            blurRadius: 12.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShado
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadlineBodyOneBaseWidget(
                                title: "profileScreen_email".tr,
                                titleTextAlign: TextAlign.center,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                titleColor: AppConstantsColor.normalTextColor
                                    .withOpacity(0.5),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              HeadlineBodyOneBaseWidget(
                                title: "profileScreen_birth".tr,
                                titleTextAlign: TextAlign.center,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                titleColor: AppConstantsColor.normalTextColor
                                    .withOpacity(0.5),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadlineBodyOneBaseWidget(
                                title: (controller.account.value.email ?? '')
                                    .toString(),
                                titleTextAlign: TextAlign.center,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                titleColor: AppConstantsColor.blackColor,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              HeadlineBodyOneBaseWidget(
                                // title: (controller.account.value.birthday ?? '')
                                //     .toString(),
                                title: controller.displayBirthday(),
                                titleTextAlign: TextAlign.center,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                titleColor: AppConstantsColor.blackColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    HeadlineBodyOneBaseWidget(
                      title: "profileScreen_privatePolicy".tr,
                      titleTextAlign: TextAlign.center,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      titleColor: AppConstantsColor.blackColor,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppConstantsColor.normalTextColor.withOpacity(0.5),
                      size: 24,
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showMyDialog(
                          context,
                          title: "profileScreen_really_accountDelete".tr,
                          // title: '정말 계정을 삭제하시겠습니까?',
                          buttonText: "profileScreen_accountDelete".tr,
                          // buttonText: '계정 삭제',
                          onTap: () async {
                            bool ret = await controller.deleteAccount();
                            if (ret == true) {
                              final int code =
                                  await SharedPreferenceService.getAuthCode;
                              AuthenticationHelper.unregister(
                                  AuthType.fromCode(code));
                              SharedPreferenceService.saveLogout();
                              Get.offAllNamed(RoutesConstants.onBoarding);
                            } else {
                              Get.back();
                            }
                          },
                        );
                      },
                      child: HeadlineBodyOneBaseWidget(
                        title: "profileScreen_accountDelete".tr,
                        titleTextAlign: TextAlign.center,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        titleColor:
                            AppConstantsColor.normalTextColor.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 15,
                        width: 1,
                        color:
                            AppConstantsColor.normalTextColor.withOpacity(0.5),
                      ),
                    ),
                    InkWell(

                        /// TODO:: Logout 처리
                        onTap: () {
                          _showMyDialog(
                            context,
                            title: 'membershipScreen_logout'.tr,
                            buttonText: 'profileScreen_logout'.tr,
                            onTap: () async {
                              int authCode =
                                  await SharedPreferenceService.getAuthCode;
                              await AuthenticationHelper.logout(
                                  AuthType.fromCode(authCode)); //=> 로그아웃
                              SharedPreferenceService.saveLogout();
                              Get.offAllNamed(RoutesConstants.onBoarding);
                            },
                          );
                        },
                        child: HeadlineBodyOneBaseWidget(
                          title: "profileScreen_logout".tr,
                          titleTextAlign: TextAlign.center,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          titleColor: AppConstantsColor.normalTextColor
                              .withOpacity(0.5),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(
    BuildContext context, {
    required String title,
    required String buttonText,
    required void Function() onTap,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text(title),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('common_button_cancel'.tr,
                  style: TextStyle(color: AppConstantsColor.normalTextColor)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(buttonText),
              onPressed: onTap,
            ),
          ],
        );
      },
    );
  }
}
