import 'package:flutter/material.dart';

import 'package:flutter_rx_stream_builder/flutter_rx_stream_builder.dart';

import '../redux/store.dart';
import '../redux/todos/actions.dart';
import '../redux/todos/state.dart';
import '../redux/todos/selectors.dart';

class TodoItemScreenArguments {
  final int id;

  TodoItemScreenArguments(this.id);
}

class TodoItemScreen extends StatelessWidget {
  static const routeName = '/item';

  const TodoItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TodoItemScreenArguments;

    final todo$ = getTodo(args.id);

    return RxStreamBuilder(
      stream: todo$,
      builder: (context, snapshot) => buildTodoItem(
        context,
        snapshot.data!,
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
            onChanged: (value) => store.dispatch(UpdateTodoAction(todo)),
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
