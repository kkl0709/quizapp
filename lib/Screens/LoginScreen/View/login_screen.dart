import 'dart:io';

import 'package:chinesequizapp/Screens/LoginScreen/Controller/login_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/image_constants.dart';
import 'package:chinesequizapp/infrastructure/mixins/authentication_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../../infrastructure/Constants/route_constants.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                ImageConstants.platformSelectImage,
                height: 95,
                width: 95,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              HeadlineBodyOneBaseWidget(
                title: 'loginScreen_title'.tr,
                titleColor: AppConstantsColor.labelTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadlineBodyOneBaseWidget(
                title: "loginScreen_content".tr,
                titleColor: AppConstantsColor.normalTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesConstants.emailLoginScreen);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Center(
                        child: HeadlineBodyOneBaseWidget(
                          title: "loginScreen_emailLogin".tr,
                          titleColor: AppConstantsColor.labelTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesConstants.memberShipScreen);
                    },
                    child: HeadlineBodyOneBaseWidget(
                      title: "loginScreen_signUp".tr,
                      titleTextAlign: TextAlign.right,
                      titleColor: AppConstantsColor.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: 2.0,
                      height: 20.0,
                      color: AppConstantsColor.normalTextColor.withOpacity(0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesConstants.emailVerificationScreen);
                    },
                    child: HeadlineBodyOneBaseWidget(
                      title: "loginScreen_findPassword".tr,
                      titleColor: AppConstantsColor.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color:
                            AppConstantsColor.normalTextColor.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: HeadlineBodyOneBaseWidget(
                        title: "loginScreen_snsLogin".tr,
                        titleColor:
                            AppConstantsColor.normalTextColor.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color:
                            AppConstantsColor.normalTextColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectPlatform(
                      context: context,
                      onClick: () => AuthenticationHelper.loginKakao(),
                      platformImage: ImageConstants.messagePlatformImage,
                    ),
                    if (Platform.isAndroid || Platform.isIOS)
                      selectPlatform(
                        context: context,
                        onClick: () => AuthenticationHelper.loginNaver(),
                        platformImage: ImageConstants.nPlatformImage,
                      ),
                    /* 잠시 숨김 처리 */
                    // selectPlatform(
                    //   context: context,
                    //   onClick: () => AuthenticationHelper.loginFacebook(),
                    //   platformImage: ImageConstants.facebookPlatformImage,
                    // ),
                    if (Platform.isIOS)
                      selectPlatform(
                        context: context,
                        onClick: () => AuthenticationHelper.loginApple(),
                        platformImage: ImageConstants.applePlatformImage,
                      ),
                    selectPlatform(
                      context: context,
                      onClick: () => AuthenticationHelper.loginGoogle(),
                      platformImage: ImageConstants.googlePlatformImage,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
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
