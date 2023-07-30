import 'package:chinesequizapp/Screens/AuthenticationScreens/View/email_otp_veryfication_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/request/http/mailer_req.dart';
import 'package:chinesequizapp/infrastructure/repositories/http/mailer_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/mailer_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class EmailVerificationController extends GetxController {
  Rx<Color> bgColor = Colors.white.obs;
  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  RxBool textField1FocusNode = false.obs;
  RxBool isLabel1 = false.obs;
  RxInt errorInt = 2.obs;
  RxString errorString = "유효한 이메일 아이디를 입력하세요.".obs;

  Future<void> onTapNext() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));
    final String code = MailerHelper.generateVerificationCode();
    await MailerApi(dio).sendEmail(
        timestamp: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
        accessKey: ApiConstants.mailerApiAccessKey,
        signature: MailerHelper.getSignature(),
        req: MailerSendReq(
            senderAddress: "no-reply@tetra.com",
            recipients: [
              Recipient(
                  address: textField1Controller.value.text,
                  name: '',
                  type: "R"),
            ],
            title: 'TETRA 인증 메일입니다.',
            body: '인증 번호를 APP 화면에 입력해주세요 : $code'));

    Get.toNamed(
      RoutesConstants.otpVerificationScreen,
      arguments: EmailOTPVerificationArgs(
        account: Account(email: textField1Controller.value.text),
        pinCode: code,
        type: VerificationType.passwordReset,
      ),
    );
  }
}
