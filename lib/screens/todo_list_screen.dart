import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';
import 'package:todo_flutter/redux/actions.dart';
import 'package:todo_flutter/redux/selectors.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({Key key}) : super(key: key);

  void checkTodo({BuildContext context, int id, bool value}) {
    final updated = Todo(id: id, complete: value);
    StoreProvider.of<AppState>(context, {}).dispatch(CheckTodoAction(updated));
  }


  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context, {}).dispatch(GetTodoListAction());

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo list'),
      ),
      body: StoreConnector<AppState, List<Todo>>(
        converter: (store) => getTodos(store.state),
        builder: this.buildList,
      ),
    );
  }

  Widget buildList(BuildContext context, List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => this.buildItem(context, todos, index),
    );
  }

  Widget buildItem(BuildContext context, List<Todo> todos, int index) {
    return ListTile(
      leading: Checkbox(
        value: todos[index].complete,
        onChanged: (value) => this.checkTodo(context: context, id: index, value: value),
      ),
      title: Text(todos[index].title),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/item',
          arguments: index,
        );
      },
    );
  }
}
