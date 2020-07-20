import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import './screens/todo_list_screen.dart';
import './screens/todo_item_screen.dart';
import './redux/state.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => TodoListScreen(),
          '/item': (conext) => TodoItemScreen(),
        },
      ),
    );
  }
}
