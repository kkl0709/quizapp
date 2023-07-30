import 'package:chinesequizapp/Screens/QuizScreens/controller/daily_quiz_controller.dart';
import 'package:get/get.dart';

class DailyQuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyQuizController());
  }
}
