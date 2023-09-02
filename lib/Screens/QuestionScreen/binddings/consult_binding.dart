import 'package:chinesequizapp/Screens/QuestionScreen/controller/consult_controller.dart';
import 'package:get/get.dart';

class ConsultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsultController());
  }
}
