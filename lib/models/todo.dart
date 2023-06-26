import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  final String id;
  final String title;
  final String description;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
