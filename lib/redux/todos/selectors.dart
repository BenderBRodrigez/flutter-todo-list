import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';

List<Todo> getTodos(AppState state) => state.todos.entities;

Todo getSelectedTodo(AppState state) {
  return state.todos.entities.singleWhere((element) => element.id == state.todos.selectedId);
}