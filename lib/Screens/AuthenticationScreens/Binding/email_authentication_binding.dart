import 'package:get/get.dart';

import '../Controller/email_authentication_controller.dart';

class EmailVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerificationController());
  }

}