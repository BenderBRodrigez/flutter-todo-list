import 'state.dart';
import '../../shared/todo.dart';

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

Todo getSelectedTodo(List<Todo> todos, int selectedId) {
  return todos.singleWhere((element) => element.id == selectedId);
}