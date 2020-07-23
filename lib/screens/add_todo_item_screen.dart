import 'package:flutter/material.dart';

import 'package:todo_flutter/redux/todos/actions.dart';
import 'package:todo_flutter/shared/todo.dart';
import 'package:todo_flutter/redux/state.dart';

class AddTodoItemScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create ToDo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            tooltip: 'Create ToDo',
            onPressed: () {
              if (!_formKey.currentState.validate()) return;
              store.dispatch(CreateTodoAction(Todo(
                  title: _titleController.text,
                  description: _descriptionController.text,
              )));
            },
          ),
        ],
      ),
      body: buildTodoItemForm(context),
    );
  }

  Widget buildTodoItemForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleFormField(context),
            buildDescriptionFormField(context),
          ],
        ),
      ),
    );
  }

  Widget buildTitleFormField(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return value.isEmpty ? 'Not empty' : null;
      },
      controller: _titleController,
      decoration: InputDecoration(
          labelText: 'ToDo Title'
      ),
    );
  }

  Widget buildDescriptionFormField(BuildContext context) {
    return TextFormField(
      minLines: 2,
      maxLines: 3,
      controller: _descriptionController,
      decoration: InputDecoration(
          labelText: 'ToDo Description'
      ),
    );
  }
}
