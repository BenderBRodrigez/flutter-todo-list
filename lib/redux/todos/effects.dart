import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rx_redux/rx_redux.dart';

import 'actions.dart';
import 'state.dart';

Stream<TodoAction> addTodoEffect(
  Stream<TodoAction> action$,
  GetState<TodoState> state,
) {
  Stream<TodoAction> execAdd(Todo todo) async* {
    yield TodoAction(todo, ActionType.added);
  }

  return action$
      .where((event) => event.type == ActionType.add)
      .map((event) => event.payload)
      .flatMap(execAdd);
}

Stream<TodoAction> removeTodoEffect(
  Stream<TodoAction> action$,
  GetState<TodoState> state,
) {
  Stream<TodoAction> executeRemove(Todo todo) async* {
    yield TodoAction(todo, ActionType.removed);
  }

  return action$
      .where((event) => event.type == ActionType.remove)
      .map((action) => action.payload)
      .flatMap(executeRemove);
}

Stream<TodoAction> toggleTodoEffect(
  Stream<TodoAction> action$,
  GetState<TodoState> state,
) {
  Stream<TodoAction> executeToggle(Todo todo) async* {
    yield TodoAction(todo, ActionType.toggled);
  }

  return action$
      .where((event) => event.type == ActionType.toggle)
      .map((action) => action.payload)
      .flatMap(executeToggle);
}
