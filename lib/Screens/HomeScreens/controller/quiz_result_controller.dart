import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QuizResultController extends GetxController {
  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  Rx<FocusNode> textField1focusNode = FocusNode().obs;

  Rx<TextEditingController> textField2Controller = TextEditingController().obs;
  Rx<FocusNode> textField2focusNode = FocusNode().obs;

  Rx<TextEditingController> textField3Controller = TextEditingController().obs;
  Rx<FocusNode> textField3focusNode = FocusNode().obs;

  Rx<TextEditingController> textField4Controller = TextEditingController().obs;
  Rx<FocusNode> textField4focusNode = FocusNode().obs;
  String? sub;
  @override
  void onInit() {
    final args = Get.arguments;
    sub = args['sub'];

    super.onInit();
  }
}
