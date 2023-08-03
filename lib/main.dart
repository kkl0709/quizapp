import 'package:chinesequizapp/generated/switch_language.dart';
import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/repositories/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../../generated/locales.g.dart';
import 'Screens/SplashScreens/binddings/splash_bindding.dart';
import 'infrastructure/Constants/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await QuizAppDatabaseService.I.init();

  KakaoSdk.init(
    nativeAppKey: ApiConstants.authKakaoNativeAppKey,
    javaScriptAppKey: ApiConstants.authKakaoJavaScriptKey,
  );
  Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  SwitchLanguage switchLanguage = SwitchLanguage();

  @override
  void initState() {
    SharedPreferenceService.getLocale().then((value) {
      Get.updateLocale(Locale(value[0], value[1]));
    });
    switchLanguage.setLanguage();
    super.initState();
  }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   switchLanguage.setLanguage();
  // }

  @override
  Widget build(BuildContext context) {
    // kakaoLogin();
    return GetMaterialApp(
      title: 'Quiz app',
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(ref: ref),
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: const Color(0xff59287b),
        primarySwatch: const MaterialColor(
          0xff59287b,
          <int, Color>{
            50: Color(0xff59287b),
            100: Color(0xff59287b),
            200: Color(0xff59287b),
            300: Color(0xff59287b),
            400: Color(0xff59287b),
            500: Color(0xff59287b),
            600: Color(0xff59287b),
            700: Color(0xff59287b),
            800: Color(0xff59287b),
            900: Color(0xff59287b),
          },
        ),
      ),
      translationsKeys: AppTranslation.translations,
      locale: Locale('ko', 'KR'),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: child!,
      ),
    );
  }
}
