import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';
import 'package:todo_flutter/redux/todos/state.dart';
import 'package:todo_flutter/redux/todos/actions.dart';
import 'package:todo_flutter/redux/todos/selectors.dart';

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  List<Todo> todos;
  Sort sortParam;

  ViewModel.build({
    @required this.todos,
    @required this.sortParam,
  }) : super(equals: [todos, sortParam]);

  @override
  ViewModel fromStore() => ViewModel.build(
    todos: state.todos.entities,
    sortParam: state.todos.sort,
  );
}

class TodoListScreen extends StatelessWidget {
  TodoListScreen({Key key}) : super(key: key);

  void _closeDrawer(BuildContext context) => Navigator.of(context).pop();

  void checkTodo({int id, bool value}) {
    final updated = Todo(id: id, complete: value);
    store.dispatch(CheckTodoAction(updated));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo list'),
        centerTitle: true,
        actions: [buildDrawerIcon(context)],
      ),
      endDrawer: buildDrawer(context),
      body: StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) {
          return buildList(context: context, todos: sortTodos(vm.todos, vm.sortParam));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildList({BuildContext context, List<Todo> todos}) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => buildItem(context, todos[index]),
    );
  }

  Widget buildItem(BuildContext context, Todo todo) {
    return ListTile(
      leading: Checkbox(
        value: todo.complete,
        onChanged: (value) => this.checkTodo(id: todo.id, value: value),
      ),
      title: Text(
        todo.title,
        style: todo.complete ? TextStyle(decoration: TextDecoration.lineThrough) : null,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/item',
          arguments: todo.id,
        );
      },
    );
  }

  Widget buildDrawerIcon(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.swap_vert),
        tooltip: 'Sort By',
        onPressed: Scaffold.of(context).openEndDrawer,
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 0,
              ),
              child: Text('Sort by:'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Date/Time'),
            onTap: () {
              store.dispatch(SortTodosAction(Sort.date));
              _closeDrawer(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Checked'),
            onTap: () {
              store.dispatch(SortTodosAction(Sort.complete));
              _closeDrawer(context);
            },
          ),
        ],
      ),
    );
  }
}
