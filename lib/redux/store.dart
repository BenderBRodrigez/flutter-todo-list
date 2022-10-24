import 'package:rx_redux/rx_redux.dart';

import 'todos/state.dart';
import 'todos/effects.dart';
import 'todos/reducer.dart';

final store = RxReduxStore(
  initialState: const TodoState([]),
  sideEffects: [addTodoEffect, removeTodoEffect, toggleTodoEffect],
  reducer: reducer,
  logger: rxReduxDefaultLogger,
);
