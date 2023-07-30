import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Constants/font_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/onBoarding_controller.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeadlineBodyOneBaseWidget(
                title: 'onBoardingScreen_title'.tr,
                titleColor: AppConstantsColor.titleColor,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
              SizedBox(
                height: 100.0,
              ),
              HeadlineBodyOneBaseWidget(
                title: 'onBoardingScreen_content1'.tr,
                titleColor: AppConstantsColor.normalTextColor,
                fontSize: 16.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadlineBodyOneBaseWidget(
                title: 'onBoardingScreen_content2'.tr,
                titleColor: AppConstantsColor.normalTextColor,
                fontSize: 16.0,
              ),
              SizedBox(
                height: 100.0,
              ),
              HeadlineBodyOneBaseWidget(
                title: 'onBoardingScreen_language'.tr,
                titleColor: AppConstantsColor.titleColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              languageSelectButton(context,
                  title: controller.languageString.value),
              SizedBox(
                height: 80.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(RoutesConstants.loginScreen);
                  SharedPreferenceService.setLocale(controller.locale.value);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppConstantsColor.buttonColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: HeadlineBodyOneBaseWidget(
                      title: 'onBoardingScreen_button_start'.tr,
                      titleColor: AppConstantsColor.buttonTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
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

  Widget languageSelectButton(BuildContext context, {required String title}) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          languagePicker(context),
          backgroundColor: AppConstantsColor.normalTextColor,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 5.0),
          child: HeadlineBodyOneBaseWidget(
            title: title,
            titleColor: AppConstantsColor.labelTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget languagePicker(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      color: AppConstantsColor.whiteColor,
      child: CupertinoPicker.builder(
        itemExtent: 30,
        childCount: controller.languageList.length,
        onSelectedItemChanged: (i) {
          controller.languageString.value = controller.languageList[i];
          controller.locale.value = controller.localeList[i].toList();
          Get.updateLocale(Locale(controller.locale[0], controller.locale[1]));
        },
        itemBuilder: (context, index) {
          return HeadlineBodyOneBaseWidget(
            title: controller.languageList[index],
            titleColor: AppConstantsColor.labelTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          );
        },
      ),
    );
  }
}
