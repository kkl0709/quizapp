import 'package:chinesequizapp/Screens/AuthenticationScreens/Controller/password_authentication_controller.dart';
import 'package:get/get.dart';

class PasswordVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordVerificationController());
  }

}
