import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';
import 'package:todo_flutter/redux/actions.dart';
import 'package:todo_flutter/redux/selectors.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context, {}).dispatch(GetTodoListAction());

    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo list'),
        ),
        body: StoreConnector<AppState, List<Todo>>(
          converter: (store) => getTodos(store.state),
          builder: (context, todos) {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/item',
                      arguments: todos[index],
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
