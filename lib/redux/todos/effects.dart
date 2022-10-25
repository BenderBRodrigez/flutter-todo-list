import 'dart:async';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:rx_redux/rx_redux.dart';

import 'actions.dart';
import 'state.dart';

Stream<ReduxAction> createTodoEffect(
  Stream<ReduxAction> action$,
  GetState<TodoState> state,
) {
  Stream<ReduxAction> getBack(action) async* {
    Navigator.of(action.payload.context).pop();
  }

  return action$
      .where((event) => event.type == ActionType.create)
      .flatMap(getBack);
}
