import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todos/todos_bloc.dart';
import '../../bloc/todos/todos_event.dart';
import '../../bloc/todos/todos_state.dart';
import '../../models/todo.dart';

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
    return BlocSelector<TodosBloc, TodosState, Todo>(
      selector: (state) => state.todos.firstWhere((todo) => todo.id == id),
      builder: (context, state) => buildTodoItem(
        context,
        state,
      ),
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
                context
                    .read<TodosBloc>()
                    .add(UpdateTodo(id: todo.id, completed: value));
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
