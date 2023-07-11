import 'package:flutter/material.dart';

import 'todo_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: TodoListScreen(),
    );
  }
}
