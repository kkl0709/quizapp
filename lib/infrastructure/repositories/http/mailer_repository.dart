import 'package:chinesequizapp/infrastructure/models/request/http/mailer_req.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'mailer_repository.g.dart';

@RestApi(baseUrl: "https://mail.apigw.ntruss.com")
abstract class MailerApi {
  factory MailerApi(Dio dio, {String baseUrl}) = _MailerApi;

  @POST("/api/v1/mails")
  Future<void> sendEmail({
    @Header("x-ncp-apigw-timestamp") required String timestamp,
    @Header("x-ncp-iam-access-key") required String accessKey,
    @Header("x-ncp-apigw-signature-v2") required String signature,
    @Header("x-ncp-lang") String lang = "ko-KR",
    @Body() required MailerSendReq req,
  });
}
