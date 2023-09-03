import 'package:chinesequizapp/Screens/QuestionScreen/controller/questions_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/font_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/components/form_input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends GetView<QuestionsController> {
  QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      debugPrint('previousPage ${controller.currentPage}');
                      if (controller.currentPage == 0) {
                        Get.back();
                      } else {
                        controller.pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  SizedBox(width: 4.0),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (int index) {
                    controller.currentPage.value = index;
                    debugPrint('index : $index');
                  },
                  itemCount: 16,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeadlineBodyOneBaseWidget(
                            title: '${index + 1}/16',
                          ),
                          SizedBox(height: 10),
                          Text("questionScreen_questions_${index + 1}".tr),
                          SizedBox(height: 20),
                          FormInputText(
                            controller: controller.listTEC[index],
                            maxLines: 10,
                            hintText: 'questionScreen_insert'.tr,
                            onChanged: (value) {
                              debugPrint('onChanged : $index');
                              controller.tecChanged();
                            },
                          ),
                          Expanded(child: SizedBox()),
                          GetBuilder<QuestionsController>(
                            builder: (controller) => ElevatedButton(
                              onPressed: controller.listTEC[index].text.isEmpty
                                  ? null
                                  : () {
                                      if (controller.currentPage.value == 15) {
                                        Get.toNamed(RoutesConstants.resultScreen);
                                      }
                                      controller.pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(10, 52),
                                backgroundColor: Color(0xFF321646), // 버튼색을 #321646로 설정
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // 버튼 모서리를 둥글게 설정
                                ),
                              ),
                              child: Text(
                                "questionScreen_next".tr,
                                style: TextStyle(
                                  color: Colors.white, // 글자색을 흰색으로 설정
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
