import 'dart:convert';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../interceptors/header_interceptor.dart';

typedef EntityFromJson<T> = T Function(Map<String, dynamic>);

class ApiService {
  static final ApiService _instance = ApiService._();

  final _url = 'http://192.168.0.188:3000';
  final _http = InterceptedHttp.build(interceptors: [
    HeaderInterceptor(),
  ]);

  _getUri(Object key) {
    String keyString;
    switch (key) {
      case (String key):
        keyString = key;
      case (List key):
        keyString = key.join('/');
      default:
        keyString = jsonEncode(key);
    }
    return Uri.parse('$_url/$keyString');
  }

  factory ApiService() {
    return _instance;
  }

  ApiService._();

  String get url => _url;

  InterceptedHttp get http => _http;

  Query<List<T>> getList<T>(Object key, EntityFromJson<T> entityFromJson) {
    return Query<List<T>>(
      key: key,
      queryFn: () async {
        final uri = _getUri(key);
        final response = await _http.get(uri);
        return jsonDecode(response.body)
            .toList()
            .map<T>((item) => entityFromJson(item))
            .toList();
      },
    );
  }

  Query<T> getEntity<T>(Object key, EntityFromJson<T> entityFromJson) {
    return Query<T>(
      key: key,
      queryFn: () async {
        final uri = _getUri(key);
        final response = await _http.get(uri);
        return entityFromJson(jsonDecode(response.body));
      },
    );
  }

  Mutation<T, T> updateEntity<T>(Object key, EntityFromJson<T> entityFromJson,
      {List<String> invalidateKeys = const [],
      List<String> refetchKeys = const []}) {
    return Mutation(
      invalidateQueries: invalidateKeys,
      refetchQueries: refetchKeys,
      queryFn: (body) async {
        final uri = _getUri(key);
        final response = await _http.put(uri, body: jsonEncode(body));
        return entityFromJson(jsonDecode(response.body));
      },
      onSuccess: (response, args) {
        CachedQuery.instance.updateQuery(
          key: key,
          updateFn: (data) => response,
        );
      },
    );
  }
}

final apiService = ApiService();
