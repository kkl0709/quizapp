import 'package:chinesequizapp/Screens/HomeScreens/views/view_result_screen.dart';
import 'package:chinesequizapp/infrastructure/Constants/api_constants.dart';
import 'package:chinesequizapp/infrastructure/Services/shared_preference_service.dart';
import 'package:chinesequizapp/infrastructure/models/account.dart';
import 'package:chinesequizapp/infrastructure/models/request/http/mailer_req.dart';
import 'package:chinesequizapp/infrastructure/repositories/db/account_repository.dart';
import 'package:chinesequizapp/infrastructure/repositories/http/mailer_repository.dart';
import 'package:chinesequizapp/infrastructure/utilities/mailer_helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ViewResultController extends GetxController {
  String? _email;
  Rx<Account> account = Account().obs;
  Rx<int> age = 0.obs;
  Rx<String> generation = ''.obs;
  Rx<String> gender = ''.obs;
  final AccountRepository _repository = AccountRepository();

  late String get;
  late String give;
  late String donGet;
  late String donGive;
  late String? sub;

  @override
  void onInit() {
    getAccount();
    final ViewResultArgs args = Get.arguments as ViewResultArgs;
    get = args.get;
    give = args.give;
    donGet = args.donGet;
    donGive = args.donGive;
    sub = args.sub;

    super.onInit();
  }

  Future<void> sendEmail() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));
    await MailerApi(dio).sendEmail(
        timestamp: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
        accessKey: ApiConstants.mailerApiAccessKey,
        signature: MailerHelper.getSignature(),
        req: MailerSendReq(
            senderAddress: "no-reply@tetra.com",
            recipients: [
              Recipient(address: 'bagmunsu21@gmail.com', name: '', type: "R"),
            ],
            title: '새로운 테트라 셀프 코칭 결과입니다..',
            body:
                '''시간 : ${DateTime.now().year}-${DateTime.now().month.toString().length > 2 ? DateTime.now().month : "${DateTime.now().month}"}-${DateTime.now().day.toString().length > 2 ? DateTime.now().day : "${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}"}<br/>
                나이 : ${generation.value}<br/>
                성별 : ${gender.value}<br/>
                주제 : ${sub}<br/>
                받는다 : ${get}<br/>
                준다 : ${give}<br/>
                못받는다 : ${donGet}<br/>
                못준다 : ${donGive}'''));
  }

  void getAccount() async {
    _email = await SharedPreferenceService.getLoggedInEmail;
    if (_email != null) {
      final resp = await _repository.getAccountByEmail(_email!);
      if (resp.data != null) {
        if (resp.data is Account) {
          account.value = resp.data;
          await ageGenerator();
          await genderGenerator();
          await sendEmail();
        }
      }
    }
  }

  Future<void> ageGenerator() async {
    if (account.value.birthday != null) {
      if (account.value.birthday! > 19000000) {
        final year = DateTime.now().year;
        final birth =
            int.parse(account.value.birthday.toString().substring(0, 4));

        age.value = year - birth;
        generation.value = '${((year - birth) ~/ 10)}0대';
      }
    }
  }

  Future<void> genderGenerator() async {
    if (account.value.gender != null) {
      if (account.value.gender == 0) {
        gender.value = ' 남';
      } else if (account.value.gender == 1) {
        gender.value = ' 여';
      }
    }
  }
}
