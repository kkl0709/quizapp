import 'dart:async';

import 'package:chinesequizapp/Screens/AuthenticationScreens/View/password_authentication_screen.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/encryption_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class PasswordVerificationController extends GetxController {
  late String? email;
  RxString resetErrorMessage = "".obs;
  final AccountRepository _repository = AccountRepository();
  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  Rx<FocusNode> textField1FocusNode = FocusNode().obs;

  Rx<TextEditingController> textField2Controller = TextEditingController().obs;
  Rx<FocusNode> textField2FocusNode = FocusNode().obs;

  RxBool isLabel1 = false.obs;
  RxBool isLabel2 = false.obs;
  RxBool isClickOnField = false.obs;

  RxInt errorInt = 2.obs;
  RxString errorString = "".obs;
  late StreamSubscription<bool> keyboardSubscription;

  RxBool isKeyboardOpen = false.obs;
  @override
  void onInit() {
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

    final PasswordVerificationScreenArgs args =
        Get.arguments as PasswordVerificationScreenArgs;

    email = args.email;

    super.onInit();
  }

  Future<bool> resetPassword() async {
    if (email != null &&
        textField1Controller.value.text == textField2Controller.value.text) {
      DatabaseResp resp = await _repository.resetPassword(
        email!,
        EncryptionHelper.encrpytPassword(
          textField1Controller.value.text,
        ),
      );
      if (resp.isException == true && resp.error != null) {
        resetErrorMessage.value = resp.error!.message;
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
}
