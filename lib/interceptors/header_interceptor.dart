import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

class HeaderInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=UTF-8';
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;
}
