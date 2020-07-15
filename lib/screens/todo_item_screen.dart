import 'package:flutter/material.dart';

import '../shared/todo.dart';

class TodoItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(todo.description),
      ),
    );
  }
}
