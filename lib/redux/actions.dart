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
    ),
  );

  @override
  AppState reduce() {
    return state.copy(todos: this.payload);
  }
}
