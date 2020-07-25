import 'package:async_redux/async_redux.dart';
import 'package:todo_flutter/redux/todos/state.dart';

import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';

class SetTodoListAction extends ReduxAction<AppState> {
  final List<Todo> payload;

  SetTodoListAction(this.payload);

  @override
  AppState reduce() {
    return state.update(todos: state.todos.update(entities: this.payload));
  }
}

class SelectTodoAction extends ReduxAction<AppState> {
  final int payload;

  SelectTodoAction(this.payload);

  @override
  AppState reduce() {
    return state.update(todos: state.todos.update(selectedId: payload));
  }
}

class CheckTodoAction extends ReduxAction<AppState> {
  final Todo payload;

  CheckTodoAction(this.payload);

  @override
  AppState reduce() {
    final todo = state.todos.entities.singleWhere((element) => element.id == payload.id);
    todo.complete = payload.complete;

    return state.update(todos: state.todos.updateCollection(entities: [todo]));
  }
}

class CreateTodoAction extends ReduxAction<AppState> {
  final Todo payload;

  CreateTodoAction(this.payload);

  @override
  AppState reduce() {
    final todo = Todo(
        id: state.todos.entities.length,
        title: payload.title,
        description: payload.description,
        complete: false,
    );
    return state.update(todos: state.todos.updateCollection(entities: [todo]));
  }

  @override
  void after() => dispatch(NavigateAction.pop());
}

class SortTodosAction extends ReduxAction<AppState> {
  final Sort payload;

  SortTodosAction(this.payload);

  @override
  AppState reduce() {
    return state.update(todos: state.todos.update(sort: payload));
  }
}