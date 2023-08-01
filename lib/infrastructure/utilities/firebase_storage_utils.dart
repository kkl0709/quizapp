import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseStorageUtils extends GetxController {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadBytes(Uint8List bytes, String uploadPath) async {
    debugPrint('uploadBytes() - uploadPath: $uploadPath');
    Reference storageRef = storage.ref(uploadPath);
    await storageRef.putData(bytes);
    String downloadURL = await storageRef.getDownloadURL();
    debugPrint('uploadBytes() - downloadURL: $downloadURL');
    return downloadURL;
  }

  static String getUploadFileName() {
    return '${Random().nextInt(900000) + 100000}' // 100000 ~ 999999 (6자리)
        '${DateTime.now().millisecondsSinceEpoch}' // 13자리
        '${Random().nextInt(900000) + 100000}'; // 100000 ~ 999999 (6자리)
  }
}