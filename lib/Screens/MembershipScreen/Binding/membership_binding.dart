import 'package:get/get.dart';

import '../Controller/membership_controller.dart';

class MembershipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MembershipController());
  }
}
