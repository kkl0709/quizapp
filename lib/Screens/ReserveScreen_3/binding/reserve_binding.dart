import 'package:chinesequizapp/Screens/ReserveScreen_3/controller/reserve_controller.dart';
import 'package:get/get.dart';

class ReserveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReserveController());
  }
}
