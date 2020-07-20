import 'package:todo_flutter/redux/state.dart';
import 'package:todo_flutter/shared/todo.dart';

class TodosState {
  List<Todo> entities;
  int selectedId;

  TodosState({
    this.entities,
    this.selectedId,
  });

  static TodosState initialState() => TodosState(
    entities: [],
    selectedId: null,
  );

  TodosState update({List<Todo> entities, int selectedId}) => TodosState(
    entities: entities ?? this.entities,
    selectedId: selectedId ?? this.selectedId,
  );

  TodosState updateCollection({List<Todo> entities}) => TodosState(
    entities: AppState.getUpdatedList(this.entities + entities),
  );
}
