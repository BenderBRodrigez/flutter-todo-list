import 'state.dart';
import 'actions.dart';
import '../store.dart';

TodoState todoReducer(TodoState state, ReduxAction<dynamic> action) {
  switch (action.type) {
    case ActionType.update:
      final todos = state.entities
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
    case ActionType.create:
      final created = Todo(
        id: state.entities.length,
        title: action.payload.todo.title,
        completed: false,
        description: action.payload.todo.description,
      );
      return TodoState([...state.entities, created]);
    case ActionType.set:
      return TodoState([...state.entities, ...action.payload]);
    default:
      return state;
  }
}
