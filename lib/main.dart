import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './screens/todo_list_screen.dart';
import './screens/todo_item_screen.dart';
import './redux/state.dart';
import './redux/reducers.dart';

void main() {
  final _initialState = AppState(todos: []);
  final Store<AppState> _store = Store<AppState>(reducer, initialState: _initialState);
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
