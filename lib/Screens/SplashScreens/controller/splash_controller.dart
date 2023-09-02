import 'dart:io';

import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/version.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/version_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  Rx<Color> bgColor = Colors.white.obs;
  final VersionRepository _repository = VersionRepository();

  Rx<String> appVersion = ''.obs;
  Rx<String> updateVersion = ''.obs;
  Rx<Version> version = Version().obs;


  @override
  void onInit() {
    print("native splash");
    Future.delayed(Duration(microseconds: 100), () async {
      getUpdateVersion().then((value) async {
        if (value) {
          _showMyDialog(
            Get.context!,
            title: '최신 버전 업데이트',
            content: '최신버전 앱으로 업데이트를 위해\n스토어로 이동합니다.',
            buttonText: '확인',
            onTap: () {
              LaunchReview.launch(
                /// 추후에 앱 출시하고 현재 앱ID 로 바꿔야 함
                androidAppId: ApiConstants.androidAppId,
                iOSAppId: ApiConstants.iOSAppId,
                writeReview: false,
              );
            },
          );
        } else {
          final bool loggedIn = await SharedPreferenceService.getLoggedIn;

          /// TODO:: TEST DATA
          if (loggedIn) {
            Get.offAllNamed(RoutesConstants.homeScreen);
          } else {
            Get.offAllNamed(RoutesConstants.onBoarding);
          }
        }
      });
    });
    super.onInit();
  }

  /// 업데이트 버전 체크 및 강제 업데이트 로직
  /// VersionRepository 참고 바람
  Future<bool> getUpdateVersion() async {
    bool result = false;
    PackageInfo info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;

    final resp = await _repository.getVersion();
    if (resp.data != null) {
      if (resp.data is Version) {
        version.value = resp.data;
        // print('getVersion data : ${version.value}');

        if (Platform.isAndroid) {
          updateVersion.value = version.value.androidVersion!;
        } else if (Platform.isIOS) {
          updateVersion.value = version.value.iosVersion!;
        }
        // print('updateVersion : ${updateVersion.value}');

        if (versionNumberFormatter(updateVersion.value) >
            versionNumberFormatter(appVersion.value)) {
          result = true;
        } else {
          result = false;
        }
      }
    } else {
      result = false;
    }
    return result;
  }

  int versionNumberFormatter(String version) {
    version = version.replaceAll(".", "");
    return int.parse(version);
  }

  Future<void> _showMyDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String buttonText,
    required void Function() onTap,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
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
