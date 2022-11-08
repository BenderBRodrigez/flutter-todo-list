import 'state.dart';
import '../utils.dart';

enum TodoActionType {
  set,
  create,
  update,
  getList,
}

class SetTodosAction extends ReduxAction<List<Todo>, TodoActionType> {
  SetTodosAction(List<Todo> payload) : super(payload, TodoActionType.set);
}

class CreateTodoAction extends ReduxAction<CreateTodo, TodoActionType> {
  CreateTodoAction(CreateTodo payload) : super(payload, TodoActionType.create);
}

class UpdateTodoAction extends ReduxAction<UpdateTodo, TodoActionType> {
  UpdateTodoAction(UpdateTodo payload) : super(payload, TodoActionType.update);
}

class GetTodosAction extends ReduxAction<Object, TodoActionType> {
  GetTodosAction() : super({}, TodoActionType.getList);
}
