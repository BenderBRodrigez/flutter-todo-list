import 'package:flutter/material.dart';

import 'package:flutter_rx_stream_builder/flutter_rx_stream_builder.dart';

import '../redux/todos/selectors.dart';
import '../redux/todos/state.dart';
import '../redux/todos/actions.dart';
import '../redux/store.dart';
import 'todo_item_screen.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = '/';

  TodoListScreen({Key? key}) : super(key: key);

  final todos$ = getTodos();

  @override
  Widget build(BuildContext context) {
    return RxStreamBuilder(
      stream: todos$,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDo list'),
        ),
        body: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) =>
              buildItem(context, snapshot.data![index]),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Todo todo) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (value) => store.dispatch(TodoAction(
          todo,
          ActionType.toggle,
        )),
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
