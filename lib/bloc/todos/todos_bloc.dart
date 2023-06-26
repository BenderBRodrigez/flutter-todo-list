import 'package:flutter_bloc/flutter_bloc.dart';

import './todos_state.dart';
import './todos_event.dart';
import '../../repositories/todos_repository.dart';
import '../../enums/state_status.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required this.todosRepository}) : super(const TodosState()) {
    on<GetTodos>(_onGetTodos);
  }

  final TodosRepository todosRepository;

  void _onGetTodos(GetTodos event, Emitter<TodosState> emit) async {
    try {
      emit(state.clone(status: StateStatus.loading));
      final todos = await todosRepository.getTodos();
      emit(
        state.clone(
          status: StateStatus.success,
          todos: todos ?? [],
        ),
      );
    } catch (error) {
      emit(state.clone(status: StateStatus.error));
    }
  }
}
