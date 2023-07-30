import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  final WidgetRef? ref;
  SplashBinding({this.ref});

  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(ref: ref));
  }
}
