part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final Task taskInfo;

  const TodoLoaded(this.taskInfo);

  @override
  List<Object> get props => [taskInfo];
}

class TodoListLoaded extends TodoState {
  final List<Task> taskList;

  const TodoListLoaded(this.taskList);

  @override
  List<Object> get props => [taskList];
}

class TodoError extends TodoState {}

class TodoIsDone extends TodoState {}

class TodoIsNotDone extends TodoState {}
