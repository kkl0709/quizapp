import 'package:chinesequizapp/Screens/QuizScreens/controller/quiz_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';
import '../../../infrastructure/Constants/image_constants.dart';
import '../controller/daily_quiz_controller.dart';

class DailyQuizScreen extends GetView<DailyQuizController> {
  const DailyQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Stack(
          children: [
            Visibility(
              visible: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(ImageConstants.homePageBackgroundImage),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    HeadlineBodyOneBaseWidget(
                      title: "dailyQuizScreen_title".tr,
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
                      title: Get.find<QuizScreenController>()
                          .question
                          .value
                          .question,
                      titleTextAlign: TextAlign.center,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      titleColor:
                          AppConstantsColor.normalTextColor.withOpacity(0.5),
                    ),
                    controller.isClick.value
                        ? SizedBox(
                            height: 40,
                          )
                        : Spacer(
                            flex: 2,
                          ),
                    !controller.isClick.value
                        ? Image.asset(
                            ImageConstants.bookLogoImage,
                            height: 90,
                            width: 170,
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppConstantsColor.disableButtonTextColor
                                    .withOpacity(0.3),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HeadlineBodyOneBaseWidget(
                                    title: controller.selectedAns.value ==
                                            Get.find<QuizScreenController>()
                                                .question
                                                .value
                                                .answer
                                        ? "dailyQuizScreen_true".tr
                                        : "dailyQuizScreen_false".tr,
                                    titleColor: AppConstantsColor.titleColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  HeadlineBodyOneBaseWidget(
                                    title: controller.selectedAns.value ==
                                            Get.find<QuizScreenController>()
                                                .question
                                                .value
                                                .answer
                                        ? "dailyQuizScreen_trueAnswer".tr
                                        : "dailyQuizScreen_falseAnswer".tr,
                                    titleColor: AppConstantsColor.titleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    controller.isClick.value
                        ? SizedBox(
                            height: 40.0,
                          )
                        : Spacer(
                            flex: 2,
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!controller.isClick.value) {
                                  controller.selectedAns.value = 0;
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: controller.selectedAns.value == 0
                                        ? AppConstantsColor.basicColor
                                        : AppConstantsColor.normalTextColor
                                            .withOpacity(0.5),
                                    width: controller.selectedAns.value == 0
                                        ? 2
                                        : 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 20.0),
                                  child: HeadlineBodyOneBaseWidget(
                                    title: controller.isClick.value
                                        ? 0 ==
                                                Get.find<QuizScreenController>()
                                                    .question
                                                    .value
                                                    .answer
                                            ? "dailyQuizScreen_button_true".tr
                                            : "dailyQuizScreen_button_false".tr
                                        : "dailyQuizScreen_button_right".tr,
                                    titleTextAlign: TextAlign.center,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    titleColor: AppConstantsColor.basicColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!controller.isClick.value) {
                                  controller.selectedAns.value = 1;
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: controller.selectedAns.value == 1
                                        ? AppConstantsColor.basicColor
                                        : AppConstantsColor.normalTextColor
                                            .withOpacity(0.5),
                                    width: controller.selectedAns.value == 1
                                        ? 2
                                        : 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20.0),
                                  child: HeadlineBodyOneBaseWidget(
                                    title: controller.isClick.value
                                        ? 1 ==
                                                Get.find<QuizScreenController>()
                                                    .question
                                                    .value
                                                    .answer
                                            ? "dailyQuizScreen_button_true".tr
                                            : "dailyQuizScreen_button_false".tr
                                        : "dailyQuizScreen_button_wrong".tr,
                                    titleTextAlign: TextAlign.center,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    titleColor: AppConstantsColor.basicColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        final quizController = Get.find<QuizScreenController>();
                        if (controller.isClick.value) {
                          Get.back();
                        } else {
                          quizController.onSubmit(
                              Get.find<DailyQuizController>()
                                  .selectedAns
                                  .value);
                        }
                        controller.isClick.value = true;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.selectedAns.value != 2
                              ? AppConstantsColor.basicColor
                              : AppConstantsColor.normalTextColor
                                  .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Center(
                          child: HeadlineBodyOneBaseWidget(
                            title: controller.isClick.value
                                ? "dailyQuizScreen_button_back".tr
                                : "dailyQuizScreen_button_submit".tr,
                            titleColor: controller.selectedAns.value != 2
                                ? AppConstantsColor.buttonTextColor
                                : AppConstantsColor.normalTextColor
                                    .withOpacity(0.5),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
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
