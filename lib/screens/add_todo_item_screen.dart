import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_rx_stream_builder/flutter_rx_stream_builder.dart';

import '../redux/todos/actions.dart';
import '../redux/todos/state.dart';
import '../redux/todos/selectors.dart';
import '../redux/store.dart';

class AddTodoItemScreen extends StatelessWidget {
  static const routeName = '/add';

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final _created$ = getTodoCreateLoaded();

  AddTodoItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RxStreamBuilder(
        stream: _created$,
        builder: (context, snapshot) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (snapshot.data == true) {
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
                    store.dispatch(CreateTodoAction(CreateTodo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    )));
                  },
                ),
              ],
            ),
            body: buildTodoItemForm(context),
          );
          },
    );
  }

  Widget buildTodoItemForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
        return value != null && value.isNotEmpty ? null : 'Not empty';
      },
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'ToDo Title'),
    );
  }

  Widget buildDescriptionFormField(BuildContext context) {
    return TextFormField(
      minLines: 2,
      maxLines: 3,
      controller: _descriptionController,
      decoration: const InputDecoration(labelText: 'ToDo Description'),
    );
  }
}
