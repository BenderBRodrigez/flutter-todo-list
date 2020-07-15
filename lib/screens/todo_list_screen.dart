import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';
import 'package:todo_flutter/redux/actions.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(GetTodoList(
      List.generate(
        20,
        (i) => Todo(
          'Todo $i',
          'Description of Todo $i',
        ),
      ),
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo list'),
        ),
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todos[index].title),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/item',
                      arguments: state.todos[index],
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
