import 'package:chinesequizapp/Screens/AuthenticationScreens/Binding/email_otp_veryfication_binding.dart';
import 'package:chinesequizapp/Screens/AuthenticationScreens/Binding/password_authentication_bindding.dart';
import 'package:chinesequizapp/Screens/AuthenticationScreens/View/email_otp_veryfication_screen.dart';
import 'package:chinesequizapp/Screens/AuthenticationScreens/View/password_authentication_screen.dart';
import 'package:chinesequizapp/Screens/Community/View/community_create_screen.dart';
import 'package:chinesequizapp/Screens/Community/View/community_detail_screen.dart';
import 'package:chinesequizapp/Screens/Community/View/community_index_screen.dart';
import 'package:chinesequizapp/Screens/EmailLoginScreen/Binding/email_login_binding.dart';
import 'package:chinesequizapp/Screens/EmailLoginScreen/View/email_login_screen.dart';
import 'package:chinesequizapp/Screens/HomeScreens/binddings/home_screen_bindding.dart';
import 'package:chinesequizapp/Screens/HomeScreens/binddings/quiz_result_binding.dart';
import 'package:chinesequizapp/Screens/HomeScreens/binddings/topic_selection_binding.dart';
import 'package:chinesequizapp/Screens/HomeScreens/binddings/view_result_binding.dart';
import 'package:chinesequizapp/Screens/HomeScreens/views/main_home_screen.dart';
import 'package:chinesequizapp/Screens/HomeScreens/views/quiz_result_screen.dart';
import 'package:chinesequizapp/Screens/HomeScreens/views/view_result_screen.dart';
import 'package:chinesequizapp/Screens/LectureScreens/views/lecture_detail_screen.dart';
import 'package:chinesequizapp/Screens/LoginScreen/Binding/login_binding.dart';
import 'package:chinesequizapp/Screens/MembershipScreen/Binding/membership_binding.dart';
import 'package:chinesequizapp/Screens/OnBordingScreens/Bindding/onBoarding_binding.dart';
import 'package:chinesequizapp/Screens/OnBordingScreens/views/onBoarding_screen.dart';
import 'package:chinesequizapp/Screens/ProfileScreens/views/profile_edit.dart';
import 'package:chinesequizapp/Screens/ProgressScreen/Views/progress_screen_view.dart';
import 'package:chinesequizapp/Screens/ProgressScreen/bindding/progress_screen_binding.dart';
import 'package:chinesequizapp/Screens/QuizScreens/binddings/daily_quiz_binding_screen.dart';
import 'package:chinesequizapp/Screens/QuizScreens/binddings/quiz_screen_bindding.dart';
import 'package:chinesequizapp/Screens/QuizScreens/views/daily_quiz_screen.dart';
import 'package:chinesequizapp/Screens/QuizScreens/views/quiz_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:get/get.dart';

import '../../Screens/AuthenticationScreens/Binding/email_authentication_binding.dart';
import '../../Screens/AuthenticationScreens/View/email_authentication_screen.dart';
import '../../Screens/HomeScreens/views/topic_selection_screen.dart';
import '../../Screens/LoginScreen/View/login_screen.dart';
import '../../Screens/MembershipScreen/View/membership_screen.dart';
import '../../Screens/SplashScreens/binddings/splash_bindding.dart';
import '../../Screens/SplashScreens/views/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: RoutesConstants.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutesConstants.onBoarding,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.cupertino,
    ),
    GetPage(
        name: RoutesConstants.loginScreen,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.memberShipScreen,
        page: () => const MembershipScreen(),
        binding: MembershipBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.emailVerificationScreen,
        page: () => const EmailVerification(),
        binding: EmailVerificationBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.otpVerificationScreen,
        page: () => const EmailOTPVerification(),
        binding: EmailOTPVerificationBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.passwordVerificationScreen,
        page: () => const PasswordVerificationScreen(),
        binding: PasswordVerificationBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.homeScreen,
        page: () => const MainHomeScreen(),
        binding: HomeScreenBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.progressScreen,
        page: () => ProgressScreen(),
        binding: ProgressScreenBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.topicSelectionScreen,
        page: () => TopicSelectionScreen(),
        binding: TopicSelectionBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.quizResultScreen,
        page: () => QuizResultScreen(),
        binding: QuizResultBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.viewResultScreen,
        page: () => ViewResultScreen(),
        binding: ViewResultBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.dailyQuizScreen,
        page: () => DailyQuizScreen(),
        binding: DailyQuizBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.quizScreen,
        page: () => QuizScreen(),
        binding: QuizScreenBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
        name: RoutesConstants.emailLoginScreen,
        page: () => EmailLoginScreen(),
        binding: EmailLoginBinding(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino //tr
        ),
    GetPage(
      name: RoutesConstants.communityIndexScreen,
      page: () => CommunityIndexScreen(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.cupertino
    ),
    GetPage(
      name: RoutesConstants.lectureDetailScreen,
      page: () => LectureDetailScreen(),
      transitionDuration: Duration(milliseconds: 500),
      transition: Transition.cupertino
    ),
    GetPage(
        name: RoutesConstants.communityDetailScreen,
        page: () => CommunityDetailScreen(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino
    ),
    GetPage(
        name: RoutesConstants.communityCreateScreen,
        page: () => CommunityCreateScreen(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino
    ),
    GetPage(
        name: RoutesConstants.profileEdit,
        page: () => ProfileEdit(),
        transitionDuration: Duration(milliseconds: 500),
        transition: Transition.cupertino
    ),
  ];
}
