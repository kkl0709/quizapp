import 'package:get/get.dart';

import '../Controller/email_login_controller.dart';

class EmailLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailLoginController());
  }
}
