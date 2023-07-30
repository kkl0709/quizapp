import 'package:chinesequizapp/Screens/HomeScreens/controller/home_screen_controller.dart';
import 'package:chinesequizapp/Screens/LectureScreens/controller/lecture_screen_controller.dart';
import 'package:chinesequizapp/Screens/ProfileScreens/controller/profile_screen_controller.dart';
import 'package:chinesequizapp/Screens/ProgressScreen/controller/progress_screen_controller.dart';

import 'package:get/get.dart';

import '../../QuizScreens/controller/quiz_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => ProgressScreenController());
    Get.lazyPut(() => QuizScreenController());
    Get.lazyPut(() => ProfileScreenController());
    Get.lazyPut(() => LectureScreenController());
  }
}
