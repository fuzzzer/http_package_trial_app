import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.todoRepository) : super(TodoInitial());

  final TodoRepository todoRepository;

  void loadTask(int id) async {
    emit(TodoLoading());
    try {
      Task taskInfo = await todoRepository.fetchTask(id: id.toString());
      emit(TodoLoaded(taskInfo));
    } on Exception catch (_) {
      emit(TodoError());
    }
  }
}
