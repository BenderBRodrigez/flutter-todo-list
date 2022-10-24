import 'package:rx_redux/rx_redux.dart';

import 'state.dart';
import '../store.dart';

Stream<List<Todo>> getTodos() {
  return store.select((s) => s.todos);
}

Stream<Todo> getTodo(int id) {
  return store.select((s) => s.todos.singleWhere((e) => e.id == id));
}
