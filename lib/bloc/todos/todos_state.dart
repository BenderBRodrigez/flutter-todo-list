import 'package:equatable/equatable.dart';

import '../../enums/state_status.dart';
import '../../models/todo.dart';

class TodosState extends Equatable {
  const TodosState({
    this.status = StateStatus.initial,
    this.todos = const [],
  });

  final List<Todo> todos;
  final StateStatus status;

  @override
  List<Object?> get props => [status, todos];

  TodosState clone({
    List<Todo>? todos,
    StateStatus? status,
  }) {
    return TodosState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }
}
