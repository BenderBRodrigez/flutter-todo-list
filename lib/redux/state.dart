import 'package:todo_flutter/shared/todo.dart';

class AppState {
  List<Todo> todos;

  AppState({this.todos});

  AppState.fromAppState(AppState state) {
    todos = state.todos;
  }
}