import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import '../shared/todo.dart';
import '../shared/todo_item_screen_arguments.dart';
import '../redux/state.dart';
import '../redux/todos/state.dart';
import '../redux/todos/actions.dart';
import '../redux/todos/selectors.dart';

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  late List<Todo> todos;
  late Sort sortParam;

  ViewModel.build({
    required this.todos,
    required this.sortParam,
  }) : super(equals: [todos, sortParam]);

  @override
  ViewModel fromStore() => ViewModel.build(
    todos: state.todos.entities,
    sortParam: state.todos.sort,
  );
}

class TodoListScreen extends StatelessWidget {
  TodoListScreen({Key? key}) : super(key: key);

  void _closeDrawer(BuildContext context) => Navigator.of(context).pop();

  void checkTodo({required int id, required bool value}) {
    final updated = UpdateTodo(id: id, complete: value);
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

  Widget buildList({required BuildContext context, List<Todo> todos = const []}) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => buildItem(context, todos[index]),
    );
  }

  Widget buildItem(BuildContext context, Todo todo) {
    return ListTile(
      leading: Checkbox(
        value: todo.complete,
        onChanged: (value) => this.checkTodo(id: todo.id, value: value ?? false),
      ),
      title: Text(
        todo.title,
        style: todo.complete ? TextStyle(decoration: TextDecoration.lineThrough) : null,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/item',
          arguments: TodoItemScreenArguments(todo.id),
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
