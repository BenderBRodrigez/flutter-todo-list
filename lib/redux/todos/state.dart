import '../state.dart';
import '../../shared/todo.dart';

enum Sort {
  date,
  complete,
}

class TodosState {
  List<Todo> entities;
  int? selectedId;
  Sort sort;

  TodosState({
    required this.entities,
    required this.selectedId,
    required this.sort,
  });

  static TodosState initialState() => TodosState(
        entities: [],
        selectedId: null,
        sort: Sort.date,
      );

  TodosState update({List<Todo>? entities, int? selectedId, Sort? sort}) =>
      TodosState(
        entities: entities ?? this.entities,
        selectedId: selectedId ?? this.selectedId,
        sort: sort ?? this.sort,
      );

  TodosState updateCollection({List<Todo> entities = const []}) => TodosState(
        entities: AppState.getUpdatedList(this.entities + entities),
        selectedId: this.selectedId,
        sort: this.sort,
      );
}
