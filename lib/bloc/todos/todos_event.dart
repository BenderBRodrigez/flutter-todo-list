import 'package:equatable/equatable.dart';

abstract class TodosEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class UpdateTodo extends TodosEvent {
  UpdateTodo({
    required this.id,
    required this.completed,
  });

  final String id;
  final bool completed;

  @override
  List<Object?> get props => [id, completed];
}

class CreateTodo extends TodosEvent {
  CreateTodo({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}
