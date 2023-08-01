import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
}