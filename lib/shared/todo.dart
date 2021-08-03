class Todo implements CreateTodo, UpdateTodo {
  final int id;
  bool complete;
  String title;
  String description;

  Todo({
    required this.id,
    required this.complete,
    required this.title,
    required this.description,
  });
}

class CreateTodo {
  String title;
  String description;

  CreateTodo({required this.title, required this.description});
}

class UpdateTodo {
  final int id;
  bool complete;

  UpdateTodo({required this.id, required this.complete});
}