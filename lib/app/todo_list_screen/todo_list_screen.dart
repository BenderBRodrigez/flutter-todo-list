import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todos/todos_bloc.dart';
import '../../bloc/todos/todos_event.dart';
import '../../bloc/todos/todos_state.dart';
import '../../models/todo.dart';
import '../add_todo_item_screen/add_todo_item_screen.dart';
import '../todo_item_screen/todo_item_screen.dart';

class TodoListScreen extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const TodoListScreen(),
    );
  }

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDo list'),
        ),
        body: ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) =>
              buildItem(context, state.todos[index]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, AddTodoItemScreen.route());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Todo todo) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          if (value != null) {
            context
                .read<TodosBloc>()
                .add(UpdateTodo(id: todo.id, completed: value));
          }
        },
      ),
      title: Text(
        todo.title,
        style: todo.completed == true
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      onTap: () {
        Navigator.push(context, TodoItemScreen.route(todo.id));
      },
    );
  }
}
