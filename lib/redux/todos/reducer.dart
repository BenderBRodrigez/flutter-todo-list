import 'state.dart';
import 'actions.dart';

TodoState reducer(TodoState state, Action action) {
  switch (action.type) {
    case ActionType.add:
    case ActionType.remove:
    case ActionType.toggle:
      return state;
    case ActionType.added:
      return TodoState([...state.todos, action.payload]);
    case ActionType.removed:
      return TodoState(
        state.todos.where((t) => t.id != action.payload.id).toList(),
      );
    case ActionType.toggled:
      final todos = state.todos
          .map((t) => t.id != action.payload.id
              ? t
              : Todo(
                  id: t.id,
                  title: t.title,
                  completed: !t.completed,
                  description: t.description,
                ))
          .toList(growable: false);
      return TodoState(todos);
    default:
      return state;
  }
}
