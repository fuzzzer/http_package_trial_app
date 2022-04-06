import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/task.dart';
import '../../../data/respiratoies/todo_repository.dart';

part 'list_tile_task_state.dart';

class ListTileTaskCubit extends Cubit<ListTileTaskState> {
  final TodoRepository todoRepository;

  ListTileTaskCubit(this.todoRepository) : super(ListTileTaskInitial());

  void isDoneChanger(Task task) {
    if (task.isDone) {
      task.isDone = false;
      emit(ListTileTaskIsNotChecked());
    } else {
      task.isDone = true;
      emit(ListTileTaskIsChecked());
    }
    todoRepository.updateTask(
      id: task.id,
      todo: task.todo,
      isDone: task.isDone,
      description: task.description,
    );
  }
}
