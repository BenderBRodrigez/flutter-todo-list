import 'dart:developer';

import 'package:async_redux/async_redux.dart';

import 'todos/state.dart';

class AppState {
  late final TodosState todos;

  AppState({
    required this.todos,
  });

  static getUpdatedList(List<dynamic> collection) => collection.toSet().toList();

  AppState update({TodosState? todos}) => AppState(
    todos: todos ?? this.todos,
  );
}

final store = Store<AppState>(
  actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
//  stateObservers: [StateLogger()],
  initialState: AppState(
    todos: TodosState.initialState(),
  ),
);

class StateLogger extends StateObserver<AppState> {
  @override
  void observe(ReduxAction<AppState> action, AppState stateIni, AppState stateEnd, int dispatchCount) {
    debugger();
  }
}