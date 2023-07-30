import 'package:chinesequizapp/Screens/Community/View/community_index_screen.dart';
import 'package:chinesequizapp/Screens/HomeScreens/views/home_screen.dart';
import 'package:chinesequizapp/Screens/ProfileScreens/views/profile_screen.dart';
import 'package:chinesequizapp/Screens/ProgressScreen/Views/progress_screen_view.dart';
import 'package:chinesequizapp/infrastructure/Constants/app_constants_color.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../QuizScreens/controller/quiz_screen_controller.dart';
import '../../QuizScreens/views/quiz_screen.dart';

class HomeScreenController extends GetxController {
  Rx<Color> bgColor = AppConstantsColor.homeBackgroundColor.obs;
  RxInt selectedIndex = 0.obs;
  String? _email;
  Rx<Account> account = Account().obs;
  final AccountRepository _repository = AccountRepository();

  RxList<Widget> navigationOptions = <Widget>[
    HomeScreen(),
    CommunityIndexScreen(),
    QuizScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ].obs;

  @override
  void onInit() {
    getAccount();
    super.onInit();
  }

  void getAccount() async {
    _email = await SharedPreferenceService.getLoggedInEmail;
    if (_email != null) {
      final resp = await _repository.getAccountByEmail(_email!);
      if (resp.data != null) {
        if (resp.data is Account) {
          account.value = resp.data;
          print(account.value);
          if (account.value.birthday == null) {
            print("print(account.value);");
            print(account.value.birthday);
            _showMyDialog(
              Get.context!,
              title: 'membershipScreen_inputBirth'.tr,
              buttonText: 'common_button_move'.tr,
              onTap: () {
                Get.back();
                onItemTapped(3);
              },
            );
          }
        }
      }
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    final quizController = Get.find<QuizScreenController>();
    quizController.refreshState();
  }

  Future<void> _showMyDialog(
    BuildContext context, {
    required String title,
    required String buttonText,
    required void Function() onTap,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text(title),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('common_button_cancel'.tr,
                  style: TextStyle(color: AppConstantsColor.normalTextColor)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(buttonText),
              onPressed: onTap,
            ),
          ],
        );
      },
    );
  }
}
