import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._();
  static const String _url = 'http://192.168.0.100:3000';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  factory ApiService() {
    return _instance;
  }

  ApiService._();

  Future<http.Response> getTodos() {
    return http.get(Uri.parse('$_url/todos'));
  }

  Future<http.Response> createTodo(Map<String, dynamic> payload) {
    return http.post(
      Uri.parse('$_url/todos'),
      headers: _headers,
      body: jsonEncode(payload),
    );
  }
}

final apiService = ApiService();
