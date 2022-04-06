part of 'todo_start_page_cubit.dart';

abstract class TodoStartPageState extends Equatable {
  const TodoStartPageState();

  @override
  List<Object> get props => [];
}

class TodoStartPageInitial extends TodoStartPageState {}

class TodoStartPageLoading extends TodoStartPageState {}

class TodoStartPageLoaded extends TodoStartPageState {
  final List<Task> taskList;

  const TodoStartPageLoaded(this.taskList);

  @override
  List<Object> get props => [taskList]; // where do we use this?
}

class TodoStartPageError extends TodoStartPageState {}
