import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:rx_redux/rx_redux.dart';

import 'state.dart';
import 'actions.dart';
import '../request/actions.dart';
import '../utils.dart';
import '../../shared/services/api_service.dart';

Stream<ReduxAction> createTodoEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  Stream<ReduxAction<CreateTodoPayload, TodoActionType>> getBack(
      action) async* {
    Navigator.of(action.payload.context).pop();
  }

  return action$.whereType<CreateTodoAction>().flatMap(getBack);
}

Stream<ReduxAction> getTodosEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  return action$
      .whereType<GetTodosAction>()
      .map((action) => RequestAction(RequestPayload(
            key: 'get_todos_request',
            request: (action) => apiService.getTodos(),
          )));
}

Stream<ReduxAction> setTodosEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  return action$
      .where((action) =>
          action.type == RequestActionType.success &&
          action.payload.key == 'get_todos_request')
      .map((action) {
    final todos = jsonDecode(action.payload.result.body)
        .toList()
        .map<Todo>((item) => Todo.fromJson(item));
    return SetTodosAction(todos.toList());
  });
}
