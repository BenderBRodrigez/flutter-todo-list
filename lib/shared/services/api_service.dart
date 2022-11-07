import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._();
  static const String _url = 'http://192.168.0.102:3000';

  factory ApiService() {
    return _instance;
  }

  ApiService._();

  Future<http.Response> getTodos() {
    return http.get(Uri.parse('$_url/todos'));
  }
}

final apiService = ApiService();
