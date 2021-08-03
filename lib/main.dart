import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import './screens/todo_list_screen.dart';
import './screens/todo_item_screen.dart';
import './screens/add_todo_item_screen.dart';
import './redux/state.dart';
import './redux/todos/actions.dart';
import './shared/todo.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    store.dispatch(SetTodoListAction(List.generate(
      10,
      (i) => Todo(
        id: i,
        title: 'Todo $i',
        description: 'Description of Todo $i',
        complete: false,
      ),
    )));

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => TodoListScreen(),
          '/item': (context) => TodoItemScreen(),
          '/add': (context) => AddTodoItemScreen(),
        },
      ),
    );
  }
}
