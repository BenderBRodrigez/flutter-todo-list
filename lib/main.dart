import 'package:flutter/material.dart';

import 'screens/todo_list_screen.dart';
import 'screens/todo_item_screen.dart';
import 'redux/store.dart';
import 'redux/todos/state.dart';
import 'redux/todos/actions.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 10; i++) {
      store.dispatch(TodoAction(
          Todo(
            id: i,
            title: 'Todo $i',
            completed: false,
            description: 'description $i',
          ),
          ActionType.add));
    }

    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        TodoListScreen.routeName: (context) => TodoListScreen(),
        TodoItemScreen.routeName: (context) => const TodoItemScreen(),
        // '/add': (context) => AddTodoItemScreen(),
      },
    );
  }
}
