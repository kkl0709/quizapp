import 'package:chinesequizapp/Screens/HomeScreens/controller/view_result_controller.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

import '../../../infrastructure/Constants/app_constants_color.dart';
import '../../../infrastructure/Constants/font_constants.dart';

class ViewResultArgs {
  final String get;
  final String give;
  final String donGet;
  final String donGive;
  final String? sub;

  const ViewResultArgs({
    this.sub,
    required this.get,
    required this.give,
    required this.donGet,
    required this.donGive,
  });
}

class ViewResultScreen extends StatefulWidget {
  const ViewResultScreen({Key? key}) : super(key: key);

  @override
  State<ViewResultScreen> createState() => _ViewResultScreenState();
}

class _ViewResultScreenState extends State<ViewResultScreen> {
  ViewResultController controller = Get.put(ViewResultController());

  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? bytes;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return viewResultScreenWidget(context);
  }

  Widget viewResultScreenWidget(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
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
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    titleColor: AppConstantsColor.titleColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Obx(
                    () => HeadlineBodyOneBaseWidget(
                      title:
                          "${DateTime.now().year}.${DateTime.now().month.toString().length > 2 ? DateTime.now().month : "${DateTime.now().month}"}.${DateTime.now().day.toString().length > 2 ? DateTime.now().day : "${DateTime.now().day}"} (${controller.generation.value}${controller.gender.value}) ",
                      fontSize: 21.0,
                      titleTextAlign: TextAlign.center,
                      fontWeight: FontWeight.w900,
                      titleColor: AppConstantsColor.titleColor,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  HeadlineBodyOneBaseWidget(
                    title: "viewResultScreen_title".tr,
                    titleTextAlign: TextAlign.center,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    titleColor: AppConstantsColor.titleColor,
                  ),
                ],
              ),
              resultContentWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  getButton(
                    onTap: () async {
                      await screenshotController.capture().then((value) async {
                        setState(() {
                          this.bytes = value;
                        });

                        saveImage(value ??
                            await screenshotController.captureFromLongWidget(
                                viewResultScreenWidget(context)));
                      });
                    },
                    title: "viewResultScreen_button_save".tr,
                  ),
                  SizedBox(width: 10.0),
                  getButton(
                      onTap: () {
                        Get.offAllNamed(RoutesConstants.homeScreen);
                      },
                      title: "viewResultScreen_button_return".tr),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget resultContentWidget() {
    return HeadlineBodyOneBaseWidget(
      title: "viewResultScreen_resultContent1".tr +
          controller.get +
          "viewResultScreen_resultContent2".tr +
          controller.donGet +
          "viewResultScreen_resultContent3".tr +
          controller.donGive +
          "viewResultScreen_resultContent4".tr +
          controller.give +
          "viewResultScreen_resultContent5".tr,
      titleTextAlign: TextAlign.center,
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      titleColor: AppConstantsColor.titleColor,
    );
  }

  Widget getButton({
    required GestureTapCallback onTap,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
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
          title: title,
          titleColor: AppConstantsColor.whiteColor,
          fontSize: 16.0,
        ),
      ),
    );
  }

  // Future shareAndSaveImage(Uint8List bytes) async {
  //   final file = XFile.fromData(bytes, mimeType: '.png');
  //   Share.shareXFiles([file]);
  // }

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
}
