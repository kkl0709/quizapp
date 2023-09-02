import 'package:chinesequizapp/Screens/QuestionScreen/controller/questions_controller.dart';
import 'package:get/get.dart';

class QuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionsController());
  }
}
