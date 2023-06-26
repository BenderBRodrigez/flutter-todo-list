import 'package:equatable/equatable.dart';

abstract class TodosEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}
