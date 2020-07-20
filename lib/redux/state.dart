import 'package:async_redux/async_redux.dart';

import 'package:todo_flutter/redux/todos/state.dart';

class AppState {
  final TodosState todos;

  AppState({
    this.todos,
  });

  static getUpdatedList(List<dynamic> collection) => collection.toSet().toList();

  AppState update({TodosState todos}) => AppState(
    todos: todos ?? this.todos,
  );
}

final store = Store<AppState>(initialState: AppState(
  todos: TodosState.initialState(),
));
