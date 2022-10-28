import 'package:rx_redux/rx_redux.dart';

import 'utils.dart';
import 'todos/state.dart';
import 'todos/effects.dart';
import 'todos/reducer.dart';

enum AppState {
  todos,
}

final store = RxReduxStore<ReduxAction, ReduxState<AppState>>(
  initialState: {
    AppState.todos: const TodoState([]),
  },
  sideEffects: [createTodoEffect],
  reducer: combineReducers<AppState>({
    AppState.todos: todoReducer,
  }),
  logger: rxReduxDefaultLogger,
);
