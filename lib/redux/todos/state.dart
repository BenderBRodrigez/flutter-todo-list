class Todo {
  final int id;
  final String title;
  final bool completed;
  final String description;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.description,
  });

  @override
  String toString() => 'Todo { $id, $title, $completed }';
}

class TodoState {
  final List<Todo> todos;

  const TodoState(this.todos);

  @override
  String toString() => 'TodoState { ${todos.length} }';
}
