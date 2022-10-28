import 'package:rx_redux/rx_redux.dart';

import 'state.dart';
import '../store.dart';

Stream<List<Todo>> getTodos() {
  return store.select((s) => s[AppState.todos].entities);
}

Stream<Todo> getTodo(int id) {
  return store
      .select((s) => s[AppState.todos].entities.singleWhere((e) => e.id == id));
}
