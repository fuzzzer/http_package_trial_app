import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/todo_repository.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit(this.todoRepository) : super(TodoListInitial());

  final TodoRepository todoRepository;

  void loadAllTasks() async {
    emit(TodoListLoading());
    try {
      var taskList = await todoRepository.fetchAllTasks();
      emit(TodoListLoaded(taskList));
    } on Exception catch (_) {
      emit(TodoListError());
    }
  }
}
