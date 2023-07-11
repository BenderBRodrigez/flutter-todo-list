import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

class HeaderInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=UTF-8';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
