import 'package:rx_redux/rx_redux.dart';

import 'todos/actions.dart';
import 'todos/state.dart';
import 'todos/effects.dart';
import 'todos/reducer.dart';

final store = RxReduxStore<ReduxAction, TodoState>(
  initialState: const TodoState([]),
  sideEffects: [createTodoEffect],
  reducer: reducer,
  logger: rxReduxDefaultLogger,
);
