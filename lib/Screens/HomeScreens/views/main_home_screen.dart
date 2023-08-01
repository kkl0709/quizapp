import 'package:chinesequizapp/Screens/HomeScreens/controller/home_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends GetView<HomeScreenController> {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.bgColor.value,
        body: Center(
          child: controller.navigationOptions
              .elementAt(controller.selectedIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house,
                color: controller.selectedIndex.value == 0
                    ? Color(0xff59287b)
                    : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 1
                    ? Icons.video_collection
                    : Icons.video_collection_outlined,
                color: controller.selectedIndex.value == 1
                    ? Color(0xff59287b)
                    : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 2
                    ? Icons.messenger
                    : Icons.messenger_outline,
                color: controller.selectedIndex.value == 2
                    ? Color(0xff59287b)
                    : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 3
                    ? CupertinoIcons.chart_bar_fill
                    : CupertinoIcons.chart_bar,
                color: controller.selectedIndex.value == 3
                    ? Color(0xff59287b)
                    : Colors.grey.shade400,
              ),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                controller.selectedIndex.value == 4
                    ? Icons.person
                    : Icons.person_outline_rounded,
                color: controller.selectedIndex.value == 4
                    ? Color(0xff59287b)
                    : Colors.grey.shade400,
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
