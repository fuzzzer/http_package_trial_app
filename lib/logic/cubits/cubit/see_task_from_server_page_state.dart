part of 'see_task_from_server_page_cubit.dart';

abstract class SeeTaskFromServerPageState extends Equatable {
  const SeeTaskFromServerPageState();

  @override
  List<Object> get props => [];
}

class SeeTaskFromServerPageInitial extends SeeTaskFromServerPageState {}

class SeeTaskFromServerPageLoading extends SeeTaskFromServerPageState {}

class SeeTaskFromServerPageLoaded extends SeeTaskFromServerPageState {
  final Task taskInfo;

  const SeeTaskFromServerPageLoaded(this.taskInfo);

  @override
  List<Object> get props => [taskInfo];
}

class SeeTaskFromServerPageError extends SeeTaskFromServerPageState {}
