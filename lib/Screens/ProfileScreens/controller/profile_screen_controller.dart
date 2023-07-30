import 'dart:async';

import 'package:chinesequizapp/Screens/AuthenticationScreens/View/password_authentication_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  String? _email;
  Rx<Account> account = Account().obs;
  final AccountRepository _repository = AccountRepository();

  Rx<DateTime> currentDateTime = DateTime.now().obs;

  Rx<Color> bgColor = AppConstantsColor.whiteColor.obs;
  RxInt selectedIndex = 0.obs;

  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  Rx<FocusNode> textField1FocusNode = FocusNode().obs;

  Rx<TextEditingController> textField2Controller = TextEditingController().obs;
  Rx<FocusNode> textField2FocusNode = FocusNode().obs;

  RxBool isLabel1 = false.obs;
  RxBool isLabel2 = false.obs;
  RxBool isLabel3 = false.obs;
  RxBool isClickOnField = false.obs;

  RxInt errorInt = 2.obs;
  RxString emailErrorMsg = "".obs;
  RxString birthdayErrorMsg = "".obs;

  late StreamSubscription<bool> keyboardSubscription;

  RxBool isKeyboardOpen = false.obs;

  @override
  void onInit() async {
    refreshState();
    super.onInit();
  }

  void refreshState() async {
    emailErrorMsg.value = "";
    birthdayErrorMsg.value = "";
    _email = await SharedPreferenceService.getLoggedInEmail;
    if (_email != null) {
      final resp = await _repository.getAccountByEmail(_email!);
      if (resp.data is Account) {
        account.value = resp.data;
      }
    }
    textField1Controller.value.text =
        (account.value.birthday ?? 0).toString(); // birth
    textField2Controller.value.text = account.value.email ?? ""; // email
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      isKeyboardOpen.value = visible;
      print("Keayborad : $visible}");
    });
  }

  Future<bool> deleteAccount() async {
    bool ret = false;
    String toastMsg = '';
    if (_email != null) {
      final DatabaseResp resp = await _repository.deleteAccount(_email ?? '');

      if (resp.isException == true && resp.error != null) {
        toastMsg = resp.error!.message;
      } else {
        toastMsg = '계정이 삭제되었습니다.';
        ret = true;
      }
    }
    Fluttertoast.showToast(
        msg: toastMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);
    return ret;
  }

  String displayBirthday() {
    String birthdayStr = account.value.birthday.toString();
    if (birthdayStr.isEmpty || birthdayStr.length != 8) {
      // return '생년월일을 확인해주세요.';
      return "profileScreenController_check_birth".tr;
    } else {
      return '${birthdayStr.substring(0, 4)}.${birthdayStr.substring(4, 6)}.${birthdayStr.substring(6, 8)}';
    }
  }

  Future<bool> onSubmit() async {
    // Validate
    if (account.value.email != textField2Controller.value.text) {
      final resp =
          await _repository.validateAccount(textField2Controller.value.text);
      if (resp.isException == true && resp.error == DbRespError.emailExists) {
        Fluttertoast.showToast(
            msg: DbRespError.emailExists.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.transparent,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    }
    final resp = await _repository.updateAccount(
      account.value.email ?? '',
      textField2Controller.value.text,
      int.parse(textField1Controller.value.text),
    );

    if (resp.isException == true) {
      return false;
    } else {
      Fluttertoast.showToast(
          msg: '계정 정보가 수정됐습니다.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.transparent,
          textColor: Colors.white,
          fontSize: 16.0);
      return true;
    }
  }

  void passwordChange() {
    if (account.value.email != null) {
      Get.toNamed(RoutesConstants.passwordVerificationScreen,
          arguments:
              PasswordVerificationScreenArgs(email: account.value.email!));
    }
  }
}
