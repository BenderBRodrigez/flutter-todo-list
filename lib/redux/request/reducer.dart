import 'state.dart';
import 'actions.dart';
import '../utils.dart';

RequestState requestReducer(RequestState state, ReduxAction action) {
  switch (action.type) {
    case RequestActionType.request:
      return state.update(
        key: action.payload.key,
        request: RequestNestedState(
          loading: true,
          loaded: false,
        ),
      );
    case RequestActionType.success:
      return state.update(
        key: action.payload.key,
        request: RequestNestedState(
          loading: false,
          loaded: true,
          data: action.payload.result.body,
        ),
      );
    case RequestActionType.fail:
      return state.update(
        key: action.payload.key,
        request: RequestNestedState(
          loading: false,
          loaded: true,
          error: action.payload.error,
        ),
      );
    default:
      return state;
  }
}
