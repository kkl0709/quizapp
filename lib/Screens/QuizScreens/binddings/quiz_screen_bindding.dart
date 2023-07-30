import 'package:chinesequizapp/Screens/QuizScreens/controller/quiz_screen_controller.dart';
import 'package:get/get.dart';

class QuizScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QuizScreenController());
  }

}