import 'dart:convert';

import '../models/todo.dart';
import '../constants/api_constants.dart';
import 'base_repository.dart';

class TodosRepository extends BaseRepository {
  final _todosUri = Uri.parse('${ApiConstants.baseUrl}/todos');

  TodosRepository();

  Future<List<Todo>?> getTodos() async {
    try {
      final response = await http.get(_todosUri);
      return jsonDecode(response.body)
          .toList()
          .map<Todo>((item) => Todo.fromJson(item))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<Todo?> createTodo(Todo payload) async {
    try {
      final response =
          await http.post(_todosUri, body: jsonEncode(payload.toJson()));
      return Todo.fromJson(jsonDecode(response.body));
    } catch (error) {
      rethrow;
    }
  }

  Future<Todo?> updateTodo(Todo payload) async {
    final uri = Uri.parse('$_todosUri/${payload.id}');
    try {
      final response = await http.put(uri, body: jsonEncode(payload.toJson()));
      return Todo.fromJson(jsonDecode(response.body));
    } catch (error) {
      rethrow;
    }
  }
}
