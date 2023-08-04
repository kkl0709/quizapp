import 'package:flutter/material.dart';

//define key used to navigate to routes...to be used globally
class Keys {
  static final navKey = GlobalKey<NavigatorState>();
}

class RoutesConstants {
  static const String splashScreen = "/";
  static const String onBoarding = "/onBoarding";
  static const String loginScreen = "/loginScreen";
  static const String emailLoginScreen = "/emailLoginScreen";
  static const String homeScreen = "/HomeScreen";
  static const String memberShipScreen = "/memberShipScreen";
  static const String emailVerificationScreen = "/emailVerificationScreen";
  static const String otpVerificationScreen = "/numberVerificationScreen";
  static const String passwordVerificationScreen =
      "/passwordVerificationScreen";
  static const String progressScreen = "/progressScreen";
  static const String profileScreen = "/profileScreen";
  static const String topicSelectionScreen = "/topicSelectionScreen";
  static const String quizResultScreen = "/quizResultScreen";
  static const String viewResultScreen = "/viewResultScreen";
  static const String dailyQuizScreen = "/dailyQuizScreen";
  static const String quizScreen = "/quizScreen";
  static const String communityIndexScreen = "/communityIndexScreen";
  static const String lectureDetailScreen = "/lectureDetailScreen";
  static const String communityDetailScreen = "/communityDetailScreen";
  static const String communityCreateScreen =  "/communityCreateScreen";
  static const String profileEdit =  "/profileEdit";
}
