import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable(explicitToJson: true)
class Todo implements CreateTodo, UpdateTodo {
  @override
  String id;
  @override
  bool completed;
  @override
  String title;
  @override
  String description;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.description,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

class CreateTodo {
  String title;
  String description;

  CreateTodo({required this.title, required this.description});
}

class UpdateTodo {
  final String id;
  bool completed;

  UpdateTodo({required this.id, required this.completed});
}

class TodoState {
  final List<Todo> entities;

  const TodoState(this.entities);

  @override
  String toString() => 'TodoState { ${entities.length} }';
}
