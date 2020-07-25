import 'package:todo_flutter/redux/todos/state.dart';
import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';

List<Todo> sortTodos(List<Todo> todos, Sort sortParam) {
  print(sortParam);
  switch (sortParam) {
    case Sort.complete:
      todos.sort((a, b) => a.complete ? 1 : -1);
      break;
    case Sort.date:
    default:
      todos.sort((a, b) => a.id.compareTo(b.id));
      break;
  }
  return todos;
}

Todo getSelectedTodo(AppState state) {
  return state.todos.entities.singleWhere((element) => element.id == state.todos.selectedId);
}