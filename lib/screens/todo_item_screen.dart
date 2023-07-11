import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import '../shared/todo.dart';
import '../shared/todo_item_screen_arguments.dart';
import '../redux/state.dart';
import '../redux/todos/actions.dart';
import '../redux/todos/selectors.dart';

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  late List<Todo> todos;
  late int selectedId;

  ViewModel.build({
    required this.todos,
    required this.selectedId,
  }) : super(equals: [todos, selectedId]);

  @override
  ViewModel fromStore() => ViewModel.build(
        todos: state.todos.entities,
        selectedId: state.todos.selectedId!,
      );
}

class TodoItemScreen extends StatelessWidget {
  void checkTodo({required int id, required bool value}) {
    final updated = UpdateTodo(id: id, complete: value);
    store.dispatch(CheckTodoAction(updated));
  }

  @override
  Widget build(BuildContext context) {
    final index =
        ModalRoute.of(context)!.settings.arguments as TodoItemScreenArguments;

    store.dispatch(SelectTodoAction(index.id));

    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return buildTodoItem(
            context: context, todo: getSelectedTodo(vm.todos, vm.selectedId));
      },
    );
  }

  Widget buildTodoItem({required BuildContext context, required Todo todo}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        centerTitle: true,
        actions: [
          Checkbox(
            value: todo.complete,
            onChanged: (value) =>
                this.checkTodo(id: todo.id, value: value ?? false),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(todo.description),
      ),
    );
  }
}
