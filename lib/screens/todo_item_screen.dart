import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';
import 'package:todo_flutter/redux/actions.dart';
import 'package:todo_flutter/redux/selectors.dart';

class TodoItemScreen extends StatelessWidget {
  void checkTodo({int id, bool value}) {
    final updated = Todo(id: id, complete: value);
    store.dispatch(CheckTodoAction(updated));
  }

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;

    store.dispatch(SelectTodoAction(index));

    return StoreConnector<AppState, Todo>(
      converter: (store) => getSelectedTodo(store.state),
      builder: this.buildTodoItem,
    );
  }

  Widget buildTodoItem(BuildContext context, Todo todo) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        centerTitle: true,
        actions: [
          Checkbox(
            value: todo.complete,
            onChanged: (value) => this.checkTodo(id: todo.id, value: value),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(todo.description),
      ),
    );
  }
}
