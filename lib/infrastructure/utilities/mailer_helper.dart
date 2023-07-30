import 'dart:convert';
import 'dart:math';

import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:crypto/crypto.dart';

class MailerHelper {
  static String generateMailerSignature(
      {required String secretKey, required String str}) {
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
    final Digest digest = hmacSha256.convert(utf8.encode(str.toString()));
    String signature = base64.encode(digest.bytes);
    return signature;
  }

  static String generateVerificationCode() {
    return (Random().nextInt(900000) + 100000).toString();
  }

  static String getSignature() {
    final space = " ";
    final newLine = "\n";
    final method = "POST";
    final uri = "/api/v1/mails";
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;

    var buffer = new StringBuffer();
    buffer.write(method);
    buffer.write(space);
    buffer.write(uri);
    buffer.write(newLine);
    buffer.write(timestamp);
    buffer.write(newLine);
    buffer.write(ApiConstants.mailerApiAccessKey);

    return MailerHelper.generateMailerSignature(
        secretKey: ApiConstants.mailerApiSecretKey, str: buffer.toString());
  }
}
