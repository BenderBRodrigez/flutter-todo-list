import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import './screens/todo_list_screen.dart';
import './screens/todo_item_screen.dart';
import './redux/state.dart';

void main() {
  final _store = Store<AppState>(initialState: AppState.initialState());
  runApp(App(store: _store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  App({this.store});

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
