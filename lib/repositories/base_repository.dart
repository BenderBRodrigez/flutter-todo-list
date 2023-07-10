import 'package:http_interceptor/http_interceptor.dart';

import '../../interceptors/header_interceptor.dart';

abstract class BaseRepository {
  final http = InterceptedHttp.build(interceptors: [
    HeaderInterceptor(),
  ]);
}
