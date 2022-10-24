import 'state.dart';

abstract class Action {
  ActionType get type;
  Todo get payload;
}

enum ActionType {
  add,
  remove,
  toggle,
  //
  added,
  removed,
  toggled,
}

class TodoAction implements Action {
  @override
  final Todo payload;
  @override
  final ActionType type;

  const TodoAction(this.payload, this.type);

  @override
  String toString() => 'Action { ${payload.id}, $type }';
}
