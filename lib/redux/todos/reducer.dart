import 'state.dart';
import 'actions.dart';

TodoState reducer(TodoState state, ReduxAction<dynamic> action) {
  switch (action.type) {
    case ActionType.update:
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
    case ActionType.create:
      final created = Todo(
        id: state.todos.length,
        title: action.payload.todo.title,
        completed: false,
        description: action.payload.todo.description,
      );
      return TodoState([...state.todos, created]);
    case ActionType.set:
      return TodoState([...state.todos, ...action.payload]);
    default:
      return state;
  }
}
