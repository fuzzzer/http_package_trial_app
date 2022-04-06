part of 'add_task_page_cubit.dart';

abstract class AddTaskPageState extends Equatable {
  const AddTaskPageState();

  @override
  List<Object> get props => [];
}

class AddTaskPageInitial extends AddTaskPageState {}

class AddTaskPageLoading extends AddTaskPageState {}

class AddTaskPageError extends AddTaskPageState {}
