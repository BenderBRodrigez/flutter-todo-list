import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todos/todos_bloc.dart';
import '../../bloc/todos/todos_event.dart';
import '../../bloc/todos/todos_state.dart';
import '../../enums/state_status.dart';

class AddTodoItemScreen extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => AddTodoItemScreen(),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();

  AddTodoItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodosBloc, TodosState, StateStatus>(
      selector: (state) => state.status,
      builder: (context, state) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (_titleController.text.isNotEmpty && state.isSuccess) {
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
                  context.read<TodosBloc>().add(CreateTodo(
                        title: _titleController.text,
                        description: _descriptionController.text,
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

  Widget buildTodoItemForm(BuildContext context, StateStatus status) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleFormField(context, status),
            buildDescriptionFormField(context, status),
          ],
        ),
      ),
    );
  }

  Widget buildTitleFormField(BuildContext context, StateStatus status) {
    return TextFormField(
      validator: (value) {
        return value != null && value.isNotEmpty ? null : 'Not empty';
      },
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'ToDo Title'),
      readOnly: status.isLoading,
    );
  }

  Widget buildDescriptionFormField(BuildContext context, StateStatus status) {
    return TextFormField(
      minLines: 2,
      maxLines: 3,
      controller: _descriptionController,
      decoration: const InputDecoration(labelText: 'ToDo Description'),
      readOnly: status.isLoading,
    );
  }
}
