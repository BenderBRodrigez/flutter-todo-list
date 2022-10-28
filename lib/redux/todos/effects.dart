import 'dart:async';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:rx_redux/rx_redux.dart';

import '../utils.dart';
import 'actions.dart';

Stream<ReduxAction> createTodoEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  Stream<ReduxAction<CreateTodoPayload, TodoActionType>> getBack(
      action) async* {
    Navigator.of(action.payload.context).pop();
  }

  return action$
      .where((event) => event.type == TodoActionType.create)
      .flatMap(getBack);
}
