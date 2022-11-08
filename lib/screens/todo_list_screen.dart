import 'package:flutter/material.dart';

import 'package:flutter_rx_stream_builder/flutter_rx_stream_builder.dart';

import '../redux/todos/selectors.dart';
import '../redux/todos/state.dart';
import '../redux/todos/actions.dart';
import '../redux/store.dart';
import 'todo_item_screen.dart';
import 'add_todo_item_screen.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = '/';

  final _todos$ = getTodos();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RxStreamBuilder(
      stream: _todos$,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDo list'),
        ),
        body: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) =>
              buildItem(context, snapshot.data![index]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddTodoItemScreen.routeName);
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
        onChanged: (value) => store.dispatch(UpdateTodoAction(todo)),
      ),
      title: Text(
        todo.title,
        style: todo.completed == true
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          TodoItemScreen.routeName,
          arguments: TodoItemScreenArguments(todo.id),
        );
      },
    );
  }
}
