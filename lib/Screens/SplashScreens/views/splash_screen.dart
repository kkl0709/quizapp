import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Center(
            child: CircularProgressIndicator(
          color: AppConstantsColor.basicColor,
        )),
      ),
    );
  }
}
