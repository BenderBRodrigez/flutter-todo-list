import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rx_redux/rx_redux.dart';

import '../utils.dart';
import 'actions.dart';

Stream<ReduxAction> requestEffect(
  Stream<ReduxAction> action$,
  GetState<ReduxState> state,
) {
  return action$
      .where((action) => action.type == RequestActionType.request)
      .switchMap((action) {
    return Stream.fromFuture(action.payload.request()).map((response) {
      final status = response.statusCode;
      if (status == 200 || status == 201) {
        return RequestSuccessAction(
            ResponsePayload(key: action.payload.key, result: response));
      }
      return RequestFailAction(ErrorPayload(
          key: action.payload.key,
          error: 'Network error ${response.statusCode}'));
    });
  });
}
