import 'package:rx_redux/rx_redux.dart';

import 'utils.dart';
import 'request/state.dart';
import 'request/effects.dart';
import 'request/reducer.dart';
import 'todos/state.dart';
import 'todos/effects.dart';
import 'todos/reducer.dart';

enum AppState {
  request,
  todos,
}

final store = RxReduxStore<ReduxAction, ReduxState<AppState>>(
  initialState: {
    AppState.request: RequestState({}),
    AppState.todos: const TodoState([]),
  },
  sideEffects: [
    requestEffect,
    createTodoEffect,
  ],
  reducer: combineReducers<AppState>({
    AppState.request: requestReducer,
    AppState.todos: todoReducer,
  }),
  logger: rxReduxDefaultLogger,
);
