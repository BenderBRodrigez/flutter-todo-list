import '../shared/todo.dart';

abstract class ActionTypes {
  static const GET_TODO_LIST = 'Get Todo List';
}

class GetTodoList {
  final type = ActionTypes.GET_TODO_LIST;
  final List<Todo> payload;

  GetTodoList(this.payload);
}