import 'dart:ui';

import 'package:chinesequizapp/Screens/HomeScreens/controller/home_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/image_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(ImageConstants.homePageBackgroundImage),
            ),
            Container(
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.top,
                    ),
                    Image.asset(
                      ImageConstants.homePageLogoImage,
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "homeScreen_title".tr,
                      titleTextAlign: TextAlign.center,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      titleColor: AppConstantsColor.buttonTextColor,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "homeScreen_content".tr,
                      titleTextAlign: TextAlign.center,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      titleColor: AppConstantsColor.buttonTextColor,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    InkWell(
                      onTap: () {
                        //Get.toNamed(RoutesConstants.topicSelectionScreen);
                        Get.toNamed(RoutesConstants.questionScreen);
                        //Get.toNamed(RoutesConstants.consultScreen);
                        //Get.toNamed(RoutesConstants.resultScreen);

                      },
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.black87.withOpacity(0.55),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 250,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 25.0,
                              ),
                              child: HeadlineBodyOneBaseWidget(
                                title: "homeScreen_button_start".tr,
                                titleTextAlign: TextAlign.center,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                titleColor: AppConstantsColor.buttonTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RoutesConstants.quizScreen);
                      },
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.black87.withOpacity(0.55),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 250,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 25.0,
                              ),
                              child: HeadlineBodyOneBaseWidget(
                                title: '퀴즈 풀기',
                                titleTextAlign: TextAlign.center,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                titleColor: AppConstantsColor.buttonTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
