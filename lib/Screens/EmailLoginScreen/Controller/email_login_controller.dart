import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/mixins/authentication_mixin.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/encryption_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginController extends GetxController {
  AccountRepository _repository = AccountRepository();

  Rx<Color> bgColor = Colors.white.obs;
  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  Rx<TextEditingController> textField2Controller = TextEditingController().obs;
  RxBool textField1FocusNode = false.obs;
  RxBool isLabel1 = false.obs;
  RxBool isLabel2 = false.obs;
  RxBool isClickOnField = false.obs;
  RxBool showPassword = false.obs;
  RxInt totalPlatform = 5.obs;
  RxInt errorInt = 2.obs;
  RxInt emailErrorInt = 2.obs;
  RxString errorString = "비밀번호는 8자 이상이어야 합니다.".obs;
  RxString emailErrorString = "유효한 이메일 아이디를 입력하세요.".obs;

  void login() async {
    final DatabaseResp resp = await _repository.login(
        textField1Controller.value.text,
        EncryptionHelper.encrpytPassword(textField2Controller.value.text));
    if (resp.isException == true) {
      if (resp.error == DbRespError.wrongAccount) {
        emailErrorInt.value = 1;
        emailErrorString.value = resp.error!.message;
      } else if (resp.error == DbRespError.wrongPassword) {
        errorString.value = resp.error!.message;
        errorInt.value = 1;
      }
    } else {
      Get.toNamed(RoutesConstants.homeScreen);
      SharedPreferenceService.saveLoggedIn(
          true, textField1Controller.value.text, AuthType.email.code);
    }
  }
}
