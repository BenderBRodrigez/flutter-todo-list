import 'dart:developer';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/todo.dart';
import '../services/api_service.dart';

class AddTodoItemScreen extends StatelessWidget {
  static Route<void> route(String id) {
    return MaterialPageRoute(
      builder: (_) => AddTodoItemScreen(id: id),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();

  final String id;

  AddTodoItemScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MutationBuilder(
      mutation: apiService.createEntity<Todo>(
        context,
        'todos',
        Todo.fromJson,
      ),
      builder: (context, state, mutate) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          log(state.status.toString());
          if (state.status == QueryStatus.success) {
            Navigator.pop(context);
          }
        });

        return Scaffold(
          appBar: AppBar(
            title: const Text('Create ToDo'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                tooltip: 'Create ToDo',
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  mutate(Todo(
                    id: id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    completed: false,
                  ));
                },
              ),
            ],
          ),
          body: buildTodoItemForm(context, state),
        );
      },
    );
  }

  Widget buildTodoItemForm(BuildContext context, MutationState state) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleFormField(context, state),
            buildDescriptionFormField(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildTitleFormField(BuildContext context, MutationState state) {
    return TextFormField(
      validator: (value) {
        return value != null && value.isNotEmpty ? null : 'Not empty';
      },
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'ToDo Title'),
      enabled: state.status != QueryStatus.loading,
    );
  }

  Widget buildDescriptionFormField(BuildContext context, MutationState state) {
    return TextFormField(
      minLines: 2,
      maxLines: 3,
      controller: _descriptionController,
      decoration: const InputDecoration(labelText: 'ToDo Description'),
      enabled: state.status != QueryStatus.loading,
    );
  }
}
