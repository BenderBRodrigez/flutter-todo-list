class Todo implements CreateTodo, UpdateTodo {
  @override
  int id;
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

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      description: json['description'],
    );
  }
}

class CreateTodo {
  String title;
  String description;

  CreateTodo({required this.title, required this.description});
}

class UpdateTodo {
  final int id;
  bool completed;

  UpdateTodo({required this.id, required this.completed});
}

class TodoState {
  final List<Todo> entities;

  const TodoState(this.entities);

  @override
  String toString() => 'TodoState { ${entities.length} }';
}
