import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_query_todo_list/services/api_service.dart';

import '../models/todo.dart';
import 'todo_item_screen.dart';

class TodoListScreen extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const TodoListScreen(),
    );
  }

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: apiService.getList<Todo>('todos', Todo.fromJson),
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDo list'),
        ),
        body: state.status == QueryStatus.success
            ? ListView.builder(
                itemCount: state.data?.length,
                itemBuilder: (context, index) =>
                    buildItem(context, state.data![index]),
              )
            : const SizedBox(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(context, AddTodoItemScreen.route());
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
            // context
            //     .read<TodosBloc>()
            //     .add(UpdateTodo(id: todo.id, completed: value));
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
