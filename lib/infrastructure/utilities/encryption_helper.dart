import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptionHelper {
  static String encrpytPassword(String pw) {
    final bytes = utf8.encode(pw);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
}
