import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_query_todo_list/services/api_service.dart';

import '../models/todo.dart';

class TodoItemScreen extends StatelessWidget {
  static Route<void> route(String id) {
    return MaterialPageRoute(
      builder: (_) => TodoItemScreen(id: id),
    );
  }

  final String id;

  const TodoItemScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: apiService.getEntity<Todo>('todos/$id', Todo.fromJson),
      builder: (context, state) => state.status == QueryStatus.success
          ? buildTodoItem(
              context,
              state.data!,
            )
          : const SizedBox(),
    );
  }

  Widget buildTodoItem(BuildContext context, Todo todo) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        centerTitle: true,
        actions: [
          Checkbox(
            value: todo.completed,
            onChanged: (value) {
              if (value != null) {
                // store.dispatch(UpdateTodoAction(
                //     UpdateTodo(id: todo.id, completed: value)));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(todo.description),
      ),
    );
  }
}
