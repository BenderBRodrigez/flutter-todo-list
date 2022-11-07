import 'dart:ui';
import 'package:flutter/material.dart';

import 'screens/todo_list_screen.dart';
import 'screens/todo_item_screen.dart';
import 'screens/add_todo_item_screen.dart';
import 'redux/store.dart';
import 'redux/todos/actions.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  PlatformDispatcher.instance.onError = (error, stack) {
    print('Error: $error');
    return true;
  };
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    store.dispatch(GetTodosAction());

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
        AddTodoItemScreen.routeName: (context) => AddTodoItemScreen(),
      },
    );
  }
}
