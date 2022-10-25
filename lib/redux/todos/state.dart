class Todo implements CreateTodo, UpdateTodo {
  @override
  final int id;
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

  @override
  String toString() => 'Todo { $id, $title, $completed }';
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
  final List<Todo> todos;

  const TodoState(this.todos);

  @override
  String toString() => 'TodoState { ${todos.length} }';
}
