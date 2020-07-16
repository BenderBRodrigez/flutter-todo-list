import 'package:todo_flutter/redux/actions.dart';
import 'package:todo_flutter/redux/state.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  switch (action.type) {
    case ActionTypes.GET_TODO_LIST:
      newState.todos = action.payload;
  }

  return newState;
}