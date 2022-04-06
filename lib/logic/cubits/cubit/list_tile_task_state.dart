part of 'list_tile_task_cubit.dart';

abstract class ListTileTaskState extends Equatable {
  const ListTileTaskState();

  @override
  List<Object> get props => [];
}

class ListTileTaskInitial extends ListTileTaskState {}

class ListTileTaskIsChecked extends ListTileTaskState {}

class ListTileTaskIsNotChecked extends ListTileTaskState {}
