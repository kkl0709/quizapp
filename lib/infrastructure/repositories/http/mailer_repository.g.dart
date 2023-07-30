// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailer_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MailerApi implements MailerApi {
  _MailerApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://mail.apigw.ntruss.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<void> sendEmail({
    required timestamp,
    required accessKey,
    required signature,
    lang = "ko-KR",
    required req,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'x-ncp-apigw-timestamp': timestamp,
      r'x-ncp-iam-access-key': accessKey,
      r'x-ncp-apigw-signature-v2': signature,
      r'x-ncp-lang': lang,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/api/v1/mails',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
