import 'package:chinesequizapp/Screens/AuthenticationScreens/Controller/email_otp_veryfication_controller.dart';
import 'package:get/get.dart';

class EmailOTPVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailOTPVerificationController());
  }
}
