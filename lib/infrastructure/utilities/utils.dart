import 'dart:io';

import 'package:chinesequizapp/infrastructure/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Utils {
  static String numberFormat(int number) {
    final numberFormatter = NumberFormat.simpleCurrency(locale: 'ko_KR', name: '', decimalDigits: 0);
    return numberFormatter.format(number);
  }

  static Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? picImage = await picker.pickImage(source: ImageSource.gallery);
    return picImage != null ? File(picImage.path) : null;
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isSameDay(DateTime dt, DateTime otherDt) {
    return dt.year == otherDt.year && dt.month == otherDt.month && dt.day == otherDt.day;
  }

  static void launchUrl(String url) {
    debugPrint('launchUrl: $url');
    UrlLauncher.launchUrl(Uri.parse(url));
  }

  static void showMessage(
    BuildContext context, {
    required String message,
    Color colorTitle = const Color(0xFFFFFFFF),
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF222222),
        duration: duration,
        content: Text(
          message,
          style: TextStyle(
            color: colorTitle,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static UserModel userModel = UserModel(
    email: '초기email',
    isPurchase: false,
    isAdmin: false,
  );
}
