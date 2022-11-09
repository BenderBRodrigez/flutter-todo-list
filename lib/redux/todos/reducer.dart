import 'state.dart';
import 'actions.dart';
import '../utils.dart';

TodoState todoReducer(TodoState state, ReduxAction action) {
  switch (action.type) {
    case TodoActionType.set:
      final allTodoItems = state.entities + action.payload;
      final List<Todo> result = [];
      for (var item in allTodoItems) {
        final lastItem = allTodoItems.lastWhere((element) => element.id == item.id);
        if (!result.contains(lastItem)) {
          result.add(lastItem);
        }
      }
      return TodoState(result);
    default:
      return state;
  }
}
