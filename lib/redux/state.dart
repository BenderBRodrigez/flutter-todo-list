import 'package:todo_flutter/shared/todo.dart';

class AppState {
  List<Todo> todos;
  int selectedId;

  AppState({
    this.todos,
    this.selectedId,
  });

  static AppState initialState() => AppState(
    todos: [],
    selectedId: null,
  );

  AppState copy({List<Todo> todos, int selectedId}) => AppState(
    todos: todos ?? this.todos,
    selectedId: selectedId ?? this.selectedId,
  );

  AppState updateTodo(Todo todo) => AppState(
    todos: (todos + [todo]).toSet().toList(),
  );
}