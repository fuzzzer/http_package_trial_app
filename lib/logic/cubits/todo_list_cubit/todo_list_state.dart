part of 'todo_list_cubit.dart';

abstract class TodoListState extends Equatable {
  const TodoListState();

  @override
  List<Object> get props => [];
}

class TodoListInitial extends TodoListState {}

class TodoListLoading extends TodoListState {}

class TodoListLoaded extends TodoListState {
  final List<Task> taskList;

  const TodoListLoaded(this.taskList);

  @override
  List<Object> get props => [taskList];
}

class TodoListError extends TodoListState {}
