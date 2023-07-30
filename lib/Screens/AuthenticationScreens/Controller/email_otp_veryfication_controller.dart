import 'package:chinesequizapp/Screens/AuthenticationScreens/View/email_otp_veryfication_screen.dart';
import 'package:chinesequizapp/Screens/AuthenticationScreens/View/password_authentication_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EmailOTPVerificationController extends GetxController {
  AccountRepository _repository = AccountRepository();

  late String code;
  late VerificationType verificationType;
  late Account? account;

  RxString errorMessage = ''.obs;
  Rx<Color> bgColor = Colors.white.obs;

  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  Rx<FocusNode> textField1FocusNode = FocusNode().obs;

  RxBool isLabel1 = false.obs;
  RxBool isButtonEnable = false.obs;

  @override
  void onInit() {
    super.onInit();
    final EmailOTPVerificationArgs args =
        Get.arguments as EmailOTPVerificationArgs;
    account = args.account;
    code = args.pinCode;
    verificationType = args.type;
  }

  void onSubmitted() async {
    if (code == textField1Controller.value.text) {
      if (verificationType == VerificationType.registration) {
        /// TODO:: 여기서 최종 로그인 처리
        if (account != null) {
          await _repository.createAccount(account!).then((resp) {
            if (resp.isException == true && resp.error != null) {
              errorMessage.value = resp.error!.message;
            } else {
              Fluttertoast.showToast(
                  msg: "회원가입이 완료되었습니다. 로그인해주세요.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.transparent,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Get.offAllNamed(RoutesConstants.onBoarding);
            }
          });
        }
      } else {
        if (account != null && account?.email != null) {
          Get.toNamed(RoutesConstants.passwordVerificationScreen,
              arguments:
                  PasswordVerificationScreenArgs(email: account!.email!));
        }
      }
    } else {
      errorMessage.value = "인증 코드를 확인해주세요.";
    }
  }
}
