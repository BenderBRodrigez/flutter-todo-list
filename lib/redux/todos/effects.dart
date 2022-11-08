import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:rx_redux/rx_redux.dart';

import 'state.dart';
import 'actions.dart';
import '../request/actions.dart';
import '../store.dart';
import '../utils.dart';
import '../../shared/services/api_service.dart';

Stream<ReduxAction> createTodoEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  return action$.whereType<CreateTodoAction>().map((action) {
    final currentState = state();
    final todo = Todo(
      id: currentState[AppState.todos].entities.length.toString(),
      title: action.payload!.title,
      completed: false,
      description: action.payload!.description,
    );
    return RequestAction(RequestPayload(
      key: 'create_todo_request',
      request: () => apiService.createTodo(todo.toJson()),
    ));
  });
}

Stream<ReduxAction> setTodoEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  return action$
      .where((action) =>
          action.type == RequestActionType.success &&
          action.payload.key == 'create_todo_request')
      .map((action) {
        final todo = jsonDecode(action.payload.result.body);
        return SetTodosAction([Todo.fromJson(todo)]);
  });
}

Stream<ReduxAction> getTodosEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  return action$
      .whereType<GetTodosAction>()
      .map((action) => RequestAction(RequestPayload(
            key: 'get_todos_request',
            request: apiService.getTodos,
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
