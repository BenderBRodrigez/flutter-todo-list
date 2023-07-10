import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo.dart';
import './todos_state.dart';
import './todos_event.dart';
import '../../repositories/todos_repository.dart';
import '../../enums/state_status.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required this.todosRepository}) : super(const TodosState()) {
    on<GetTodos>(_onGetTodos);
    on<UpdateTodo>(_onUpdateTodo);
    on<CreateTodo>(_onCreateTodo);
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

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) async {
    try {
      emit(state.clone(status: StateStatus.loading));
      final currentTodo =
          state.todos.firstWhere((element) => element.id == event.id);
      final updatedTodo = Todo(
        id: currentTodo.id,
        title: currentTodo.title,
        description: currentTodo.description,
        completed: event.completed,
      );
      final todo = await todosRepository.updateTodo(updatedTodo);
      emit(
        state.clone(
          status: StateStatus.success,
          todos: [
            ...state.todos.where((element) => element.id != todo!.id),
            todo!,
          ],
        ),
      );
    } catch (error) {
      emit(state.clone(status: StateStatus.error));
    }
  }

  void _onCreateTodo(CreateTodo event, Emitter<TodosState> emit) async {
    try {
      emit(state.clone(status: StateStatus.loading));
      final createdTodo = Todo(
        id: state.todos.length.toString(),
        title: event.title,
        description: event.description,
        completed: false,
      );
      final todo = await todosRepository.createTodo(createdTodo);
      emit(
        state.clone(
          status: StateStatus.success,
          todos: [
            ...state.todos,
            todo!,
          ],
        ),
      );
    } catch (error) {
      emit(state.clone(status: StateStatus.error));
    }
  }
}
