import 'package:async_redux/async_redux.dart';

import '../shared/todo.dart';
import '../redux/state.dart';

class GetTodoListAction extends ReduxAction<AppState> {
  final payload = List.generate(
    20,
    (i) => Todo(
      id: i,
      title: 'Todo $i',
      description: 'Description of Todo $i',
      complete: false,
    ),
  );

  @override
  AppState reduce() {
    return state.copy(todos: this.payload);
  }
}

class SelectTodoAction extends ReduxAction<AppState> {
  final int payload;

  SelectTodoAction(this.payload);

  @override
  AppState reduce() {
    return state.copy(selectedId: payload);
  }
}

class CheckTodoAction extends ReduxAction<AppState> {
  final Todo payload;

  CheckTodoAction(this.payload);

  @override
  AppState reduce() {
    final todo = state.todos.singleWhere((element) => element.id == payload.id);
    todo.complete = payload.complete;

    return state.updateTodo(todo);
  }
}