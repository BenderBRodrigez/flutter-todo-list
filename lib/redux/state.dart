import 'package:todo_flutter/shared/todo.dart';

class AppState {
  List<Todo> todos;

  AppState({this.todos});

  static AppState initialState() => AppState(
    todos: [],
  );

  AppState copy({List<Todo> todos}) => AppState(
    todos: todos ?? this.todos,
  );
}