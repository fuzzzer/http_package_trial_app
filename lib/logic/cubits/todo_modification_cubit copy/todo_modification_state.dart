part of 'todo_modification_cubit.dart';

abstract class TodoModificationState extends Equatable {
  const TodoModificationState();

  @override
  List<Object> get props => [];
}

class TodoModificationInitial extends TodoModificationState {}

class TodoModificationLoading extends TodoModificationState {}

class TodoModificationLoaded extends TodoModificationState {}

class TodoModificationError extends TodoModificationState {}

class TodoIsDone extends TodoModificationState {}

class TodoIsNotDone extends TodoModificationState {}
