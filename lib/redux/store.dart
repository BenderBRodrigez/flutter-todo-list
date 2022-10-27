import 'package:rx_redux/rx_redux.dart';

import 'todos/actions.dart';
import 'todos/state.dart';
import 'todos/effects.dart';
import 'todos/reducer.dart';

typedef ReduxState = Map<String, dynamic>;

class ReduxAction<P> {
  ActionType type;
  P payload;

  ReduxAction(this.payload, this.type);
}

Map<String, dynamic> Function(ReduxState state, ReduxAction action)
    combineReducers(Map<String, Function> reducers) {
  ReduxState combiner(
    ReduxState state,
    ReduxAction action,
  ) {
    var hasChanged = false;
    final ReduxState nextState = {};
    reducers.forEach((key, reducer) {
      final previousStateForKey = state[key];
      final nextStateForKey = reducer(previousStateForKey, action);
      nextState[key] = nextStateForKey;
      hasChanged = hasChanged || nextStateForKey != previousStateForKey;
    });
    return hasChanged ? nextState : state;
  }

  return combiner;
}

final store = RxReduxStore<ReduxAction, ReduxState>(
  initialState: {
    'todos': const TodoState([]),
  },
  sideEffects: [createTodoEffect],
  reducer: combineReducers({
    'todos': todoReducer,
  }),
  logger: rxReduxDefaultLogger,
);
