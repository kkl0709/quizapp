import 'dart:ui';

import 'package:chinesequizapp/Screens/QuestionScreen/controller/result_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/foundation.dart';

class ResultScreen extends GetView<ResultController> {
  ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return viewResultScreenWidget(context);
  }

  GlobalKey _globalKey = GlobalKey();

  @override
  Widget viewResultScreenWidget(BuildContext context) {
    return Screenshot(
      controller: controller.screenshotController,
      child: RepaintBoundary(
        key: _globalKey,
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
                        Get.back();
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: renderColumn(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveImage(Uint8List bytes) async {
    Map<Object?, Object?> result = await ImageGallerySaver.saveImage(bytes);
    // print('saveImage result : ${result.containsKey('isSuccess')}');

    if (result.containsKey('isSuccess')) {
      Fluttertoast.showToast(
          msg: "Photo Save Complete",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.transparent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Photo Save Fail",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.transparent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  renderColumn(BuildContext context) {
    return SizedBox(
      //height: 2000,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(
            "questionScreen_basicResult".tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          Container(
            height: 15.h,
            padding: EdgeInsets.all(10),
            child: Text('aaa'),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF), // 내부 색깔을 #FFFFFF로 설정
              borderRadius: BorderRadius.circular(10), // 테두리를 둥글게 설정
              border: Border.all(
                color: Color(0xFFEEEEEE), // 테두리 색깔을 #EEEEEE로 설정
                width: 1, // 테두리 두께를 1로 설정 (원하는 두께로 변경 가능)
              ),
            ),
            // 원하는 크기나 내부 위젯을 여기에 추가
          ),
          Column(
            children: List.generate(
                20,
                (index) => Container(
                      height: 70,
                      child: Text('aa'),
                    )),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    controller.screenshotController
                        .captureFromLongWidget(
                      InheritedTheme.captureAll(context, Material(child: renderColumn(context))),
                      delay: Duration(milliseconds: 100),
                      context: context,
                    )
                        .then((capturedImage) {
                      saveImage(capturedImage).then((value) {
                        debugPrint('저장완료');
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(10, 52),
                    backgroundColor: Color(0xFFE0E0E0), // 버튼색을 #321646로 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 버튼 모서리를 둥글게 설정
                    ),
                  ),
                  child: Text(
                    "questionScreen_saveGallery".tr,
                    style: TextStyle(color: Color(0xFF424242), fontSize: 24, letterSpacing: -2.0),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutesConstants.consultScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(10, 52),
                    backgroundColor: Color(0xFF321646),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "questionScreen_consultReserve".tr,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
