import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TopicSelectionController extends GetxController {
  final AccountRepository _repository = AccountRepository();
  String? _email;

  Rx<Account> account = Account().obs;
  Rx<TextEditingController> textFieldController = TextEditingController().obs;
  Rx<FocusNode> textFieldFocusNode = FocusNode().obs;

  @override
  void onInit() async {
    _email = await SharedPreferenceService.getLoggedInEmail;
    if (_email != null) {
      final resp = await _repository.getAccountByEmail(_email!);
      if (resp.data is Account) {
        account.value = resp.data;
      }
      super.onInit();
    }
  }
}
