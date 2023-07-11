import 'dart:convert';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../interceptors/header_interceptor.dart';

class ApiService {
  static final ApiService _instance = ApiService._();

  final _url = 'http://192.168.1.147:3000';
  final _http = InterceptedHttp.build(interceptors: [
    HeaderInterceptor(),
  ]);

  factory ApiService() {
    return _instance;
  }

  ApiService._();

  String get url => _url;

  InterceptedHttp get http => _http;

  Query<List<T>> getList<T>(String key, Function mapper) {
    return Query<List<T>>(
      key: key,
      queryFn: () async {
        final uri = Uri.parse('$_url/$key');
        final response = await _http.get(uri);
        return jsonDecode(response.body).toList().map<T>(mapper).toList();
      },
    );
  }

  Query<T> getEntity<T>(String key, Function mapper) {
    return Query<T>(
      key: key,
      queryFn: () async {
        final uri = Uri.parse('$_url/$key');
        final response = await _http.get(uri);
        return mapper(jsonDecode(response.body));
      },
    );
  }
}

final apiService = ApiService();
