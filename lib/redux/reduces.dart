import 'package:todo_flutter/redux/actions.dart';
import 'package:todo_flutter/redux/state.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

//  switch (action) {
//    case GetTodoList:
//      newState.todos = action.payload;
//  }
  if (action is GetTodoList) {
    newState.todos = action.payload;
  }

  return newState;
}