import 'package:flutter/material.dart';

import 'state.dart';
import '../store.dart';

enum ActionType {
  set,
  create,
  update,
}

class SetTodosAction extends ReduxAction<List<Todo>> {
  SetTodosAction(List<Todo> payload) : super(payload, ActionType.set);
}

class CreateTodoPayload {
  CreateTodo todo;
  BuildContext context;

  CreateTodoPayload(this.todo, this.context);
}

class CreateTodoAction extends ReduxAction<CreateTodoPayload> {
  CreateTodoAction(CreateTodoPayload payload)
      : super(payload, ActionType.create);
}

class UpdateTodoAction extends ReduxAction<UpdateTodo> {
  UpdateTodoAction(UpdateTodo payload) : super(payload, ActionType.update);
}
