import 'package:flutter/material.dart';

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

class CreateTodoPayload {
  CreateTodo todo;
  BuildContext context;

  CreateTodoPayload(this.todo, this.context);
}

class CreateTodoAction extends ReduxAction<CreateTodoPayload, TodoActionType> {
  CreateTodoAction(CreateTodoPayload payload)
      : super(payload, TodoActionType.create);
}

class UpdateTodoAction extends ReduxAction<UpdateTodo, TodoActionType> {
  UpdateTodoAction(UpdateTodo payload) : super(payload, TodoActionType.update);
}

class GetTodosAction extends ReduxAction<Object, TodoActionType> {
  GetTodosAction() : super({}, TodoActionType.getList);
}
