import 'package:chinesequizapp/Screens/QuestionScreen/controller/consult_call_controller.dart';
import 'package:get/get.dart';

class ConsultCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConsultCallController());
  }
}
