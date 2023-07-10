import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo_list/bloc/todos/todos_bloc.dart';

import '../bloc/todos/todos_event.dart';
import '../repositories/todos_repository.dart';
import '../themes/app_theme.dart';
import 'todo_list_screen/todo_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => TodosRepository(),
      child: BlocProvider(
        create: (BuildContext context) => TodosBloc(
          todosRepository: context.read<TodosRepository>(),
        )..add(GetTodos()),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: _navigatorKey,
      theme: AppTheme.defaultTheme,
      home: const TodoListScreen(),
    );
  }
}
