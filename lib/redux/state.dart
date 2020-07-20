import 'package:async_redux/async_redux.dart';

import 'package:todo_flutter/shared/todo.dart';

class AppState {
  List<Todo> todos;
  int selectedId;

  AppState({
    this.todos,
    this.selectedId,
  });

  AppState copy({List<Todo> todos, int selectedId}) => AppState(
    todos: todos ?? this.todos,
    selectedId: selectedId ?? this.selectedId,
  );

  AppState updateTodo(Todo todo) => AppState(
    todos: (todos + [todo]).toSet().toList(),
  );
}

final store = Store<AppState>(initialState: AppState(
  todos: [],
  selectedId: null,
));