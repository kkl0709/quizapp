import 'package:chinesequizapp/Screens/HomeScreens/controller/home_screen_controller.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/user_model.dart';
import 'package:chinesequizapp/infrastructure/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateAccount();
  }

  updateAccount() async {
    String email = await SharedPreferenceService.getLoggedInEmail;
    debugPrint('존재 $email');
    try {
      final userDoc = await FirebaseFirestore.instance.collection('user').doc(email).get();
      if (!userDoc.exists) {
        debugPrint('존재하지 않음');
        await FirebaseFirestore.instance.collection('user').doc(email).set(UserModel(
              email: email,
              isPurchase: false,
              isAdmin: false,
            ).toJson());
        final userDoc = await FirebaseFirestore.instance.collection('user').doc(email).get();
        Utils.userModel = UserModel.fromJson(userDoc.data()!);
      } else {
        debugPrint('존재함');
        Utils.userModel = UserModel.fromJson(userDoc.data()!);
      }
    } catch (e, s) {}
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Center(
          child: controller.navigationOptions.elementAt(controller.selectedIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 0 ? CupertinoIcons.house_fill : CupertinoIcons.house,
                color: controller.selectedIndex.value == 0 ? Color(0xff59287b) : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 1
                    ? Icons.video_collection
                    : Icons.video_collection_outlined,
                color: controller.selectedIndex.value == 1 ? Color(0xff59287b) : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 2 ? Icons.messenger : Icons.messenger_outline,
                color: controller.selectedIndex.value == 2 ? Color(0xff59287b) : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 3
                    ? CupertinoIcons.chart_bar_fill
                    : CupertinoIcons.chart_bar,
                color: controller.selectedIndex.value == 3 ? Color(0xff59287b) : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 4 ? Icons.person : Icons.person_outline_rounded,
                color: controller.selectedIndex.value == 4 ? Color(0xff59287b) : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.black,
          iconSize: 24,
          onTap: controller.onItemTapped,
          elevation: 5,
        ),
      ),
    );
  }
}
