import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';

List<Todo> getTodos(AppState state) => state.todos;

Todo getSelectedTodo(AppState state) => state.todos.singleWhere((element) => element.id == state.selectedId);