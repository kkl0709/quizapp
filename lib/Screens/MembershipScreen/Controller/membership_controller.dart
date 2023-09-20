import 'package:chinesequizapp/Screens/AuthenticationScreens/View/email_otp_veryfication_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:chinesequizapp/infrastructure/Constants/route_constants.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/request/http/mailer_req.dart';
import 'package:chinesequizapp/infrastructure/models/response/database_resp.dart';
import 'package:chinesequizapp/infrastructure/models/user_model.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/http/mailer_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/encryption_helper.dart';
import 'package:chinesequizapp/infrastructure/utilities/mailer_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MembershipController extends GetxController {
  AccountRepository _repository = AccountRepository();
  Account? _account;

  RxString emailTextFieldError = ''.obs;

  Rx<TextEditingController> textField1Controller = TextEditingController().obs;
  Rx<FocusNode> textField1FocusNode = FocusNode().obs;

  Rx<TextEditingController> textField2Controller = TextEditingController().obs;
  Rx<FocusNode> textField2FocusNode = FocusNode().obs;

  Rx<TextEditingController> textField3Controller = TextEditingController().obs;
  Rx<FocusNode> textField3FocusNode = FocusNode().obs;

  Rx<TextEditingController> textField4Controller = TextEditingController().obs;
  Rx<FocusNode> textField4FocusNode = FocusNode().obs;

  Rx<TextEditingController> textField5Controller = TextEditingController().obs;
  Rx<FocusNode> textField5FocusNode = FocusNode().obs;

  var formKey = GlobalKey<FormState>();

  RxBool isLabel1 = false.obs;
  RxBool isLabel2 = false.obs;
  RxBool isLabel3 = false.obs;
  RxBool isLabel4 = false.obs;
  RxBool isLabel5 = false.obs;

  RxInt gender = 3.obs;

  RxBool isAcceptTermAndCondition = false.obs;

  /// TODO:: KM - 로그인 구현
  Future<void> validateAccount() async {
    final resp = await _repository.validateAccount(textField1Controller.value.text);
    if (resp.isException == true && resp.error == DbRespError.emailExists) {
      emailTextFieldError.value = DbRespError.emailExists.message;
    } else {
      emailTextFieldError.value = '';
    }
  }

  void createAccount() async {
    _account = Account(
        authType: 0,
        email: textField1Controller.value.text,
        password: EncryptionHelper.encrpytPassword(textField2Controller.value.text),
        name: textField4Controller.value.text,
        birthday: int.parse(textField5Controller.value.text),
        gender: gender.value,
        createdAt: DateTime.now());

    if (_account != null) {
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
                    name: textField4Controller.value.text,
                    type: "R"),
              ],
              title: 'TETRA 인증 메일입니다.',
              body: '인증 번호를 APP 화면에 입력해주세요 : $code'));
      debugPrint('CreateACcount');
      await FirebaseFirestore.instance.collection('user').doc(textField1Controller.value.text).set(UserModel(
            email: textField1Controller.value.text,
            isPurchase: false,
            isAdmin: false,
          ).toJson());

      /// TODO:: 인증 화면 이동
      Get.toNamed(
        RoutesConstants.otpVerificationScreen,
        arguments: EmailOTPVerificationArgs(
          account: _account!,
          pinCode: code,
          type: VerificationType.registration,
        ),
      );
    }
  }
}
