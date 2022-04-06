part of 'update_task_page_cubit.dart';

abstract class UpdateTaskPageState extends Equatable {
  const UpdateTaskPageState();

  @override
  List<Object> get props => [];
}

class UpdateTaskPageInitial extends UpdateTaskPageState {}

class UpdateTaskPageUpdateLoading extends UpdateTaskPageState {}

class UpdateTaskPageError extends UpdateTaskPageState {}
