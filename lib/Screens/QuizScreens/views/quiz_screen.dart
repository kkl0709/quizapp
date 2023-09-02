import 'dart:ui';

import 'package:chinesequizapp/Screens/QuizScreens/controller/quiz_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/image_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';

class QuizScreen extends GetView<QuizScreenController> {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(QuizScreenController());
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        appBar: AppBar(backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 56,
          title: SizedBox(
            width: double.infinity,
            height: 56,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Color(0xff1E1F27),),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  HeadlineBodyOneBaseWidget(
                    title: "quizScreen_dailyQuiz".tr,
                    titleTextAlign: TextAlign.center,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    titleColor: AppConstantsColor.blackColor,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: AppConstantsColor.lightPinkColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: HeadlineBodyOneBaseWidget(
                        title:
                            "${controller.currentDateTime.value.year}. ${controller.currentDateTime.value.month.toString().length == 1 ? "0${controller.currentDateTime.value.month}" : "${controller.currentDateTime.value.month}"}. ${controller.currentDateTime.value.day}",
                        titleTextAlign: TextAlign.center,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        titleColor: AppConstantsColor.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  HeadlineBodyOneBaseWidget(
                    title: controller.question.value.question,
                    titleTextAlign: TextAlign.center,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    titleColor:
                        AppConstantsColor.normalTextColor.withOpacity(0.5),
                  ),
                  SizedBox(height: 82.0),
                  Image.asset(
                    ImageConstants.bookLogoImage,
                    height: 90,
                    width: 170,
                  ),
                  SizedBox(height: 52.0),
                  InkWell(
                    onTap: () {
                      // final result =
                      Get.toNamed(RoutesConstants.dailyQuizScreen);

                      // if (result != null) {
                      //   controller.isQuizComplete.value = true;
                      // }
                    },
                    child: Center(
                      child: new ClipRect(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppConstantsColor.basicColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 20.0),
                            child: HeadlineBodyOneBaseWidget(
                              title: "quizScreen_button_true".tr,
                              titleTextAlign: TextAlign.center,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              titleColor: AppConstantsColor.buttonTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Visibility(
              visible: controller.isQuizComplete.value,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                            ImageConstants.completeQuizBackgroundImage),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            HeadlineBodyOneBaseWidget(
                              title: "quizScreen_title".tr,
                              titleTextAlign: TextAlign.center,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              titleColor: AppConstantsColor.blackColor,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            HeadlineBodyOneBaseWidget(
                              title: controller.question.value.question,
                              titleTextAlign: TextAlign.center,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              titleColor: AppConstantsColor.normalTextColor
                                  .withOpacity(0.5),
                            ),
                            Spacer(),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 44.0),
                                child: new ClipRect(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color:
                                              Colors.black87.withOpacity(0.7)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              size: 40,
                                              color: AppConstantsColor
                                                  .checkMarkColor,
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            HeadlineBodyOneBaseWidget(
                                              title: "quizScreen_dailyQuiz".tr,
                                              titleTextAlign: TextAlign.center,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                              titleColor:
                                                  AppConstantsColor.whiteColor,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            HeadlineBodyOneBaseWidget(
                                              title:
                                                  "${controller.currentDateTime.value.year}. ${controller.currentDateTime.value.month.toString().length == 1 ? "0${controller.currentDateTime.value.month}" : "${controller.currentDateTime.value.month}"}. ${controller.currentDateTime.value.day.toString().length == 1 ? "0${controller.currentDateTime.value.day}" : "${controller.currentDateTime.value.day}"}",
                                              titleTextAlign: TextAlign.center,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              titleColor:
                                                  AppConstantsColor.whiteColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
