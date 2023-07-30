import 'package:chinesequizapp/Screens/HomeScreens/controller/topic_selection_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Constants/font_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicSelectionScreen extends GetView<TopicSelectionController> {
  const TopicSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  HeadlineBodyOneBaseWidget(
                    title: "common_button_back".tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    titleColor: AppConstantsColor.titleColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HeadlineBodyOneBaseWidget(
              title:
                  "${controller.account.value.name == null ? '' : '${controller.account.value.name}' + 'topicSelectionScreen_title'.tr}",
              fontSize: 24.0,
              titleTextAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 85.0),
              child: HeadlineBodyOneBaseWidget(
                title: "topicSelectionScreen_content".tr,
                titleTextAlign: TextAlign.center,
                titleColor: AppConstantsColor.titleColor,
                fontSize: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: HeadlineBodyOneBaseWidget(
                      title: "topicSelectionScreen_subject".tr,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      titleColor: AppConstantsColor.titleColor,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: AppConstantsColor.disableButtonTextColor,
                        ),
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: controller.textFieldController.value,
                        focusNode: controller.textFieldFocusNode.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "topicSelectionScreen_select".tr,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                        onTapOutside: (event) {
                          controller.textFieldFocusNode.value.unfocus();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RoutesConstants.quizResultScreen, arguments: {
                  'sub': controller.textFieldController.value.text
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppConstantsColor.buttonColor,
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.3),
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: HeadlineBodyOneBaseWidget(
                  title: "topicSelectionScreen_button_start".tr,
                  titleColor: AppConstantsColor.whiteColor,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
