typedef ReduxState<S> = Map<S, dynamic>;

class ReduxAction<P, T> {
  P? payload;
  T type;

  ReduxAction(this.payload, this.type);
}

ReduxState<S> Function(ReduxState<S> state, ReduxAction action)
    combineReducers<S>(Map<S, Function> reducers) {
  ReduxState<S> combiner(
    ReduxState<S> state,
    ReduxAction action,
  ) {
    var hasChanged = false;
    final ReduxState<S> nextState = {};
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
