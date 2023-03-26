import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/task.dart';
import '../../../data/recently_deleted_database.dart';
import '../../../data/repositories/todo_repository.dart';

part 'todo_modification_state.dart';

class TodoModificationCubit extends Cubit<TodoModificationState> {
  TodoModificationCubit(this.todoRepository) : super(TodoModificationInitial());

  final TodoRepository todoRepository;

  Future<bool> checkIdAvailability(String id) async {
    bool result = false;
    try {
      await todoRepository.fetchTask(id: id);
    } on Exception catch (_) {
      result = true;
    }
    return result;
  }

  void addTask({
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
  }) async {
    emit(TodoModificationLoading());
    try {
      await todoRepository.createTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      emit(TodoModificationInitial());
    } on Exception catch (_) {
      emit(TodoModificationError());
    }
  }

  void deleteTask(Task taskInfo) {
    todoRepository.delateTask(id: taskInfo.id.toString());
    saveDeletedTask(taskInfo);
  }

  void saveDeletedTask(Task taskInfo) {
    deletedTasks.add(taskInfo);
  }

  void removeTaskFromRecentlyDeleted(Task taskInfo) {
    deletedTasks.remove(taskInfo);
  }

  updateTask({
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
  }) async {
    emit(TodoModificationLoading());
    try {
      await todoRepository.updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
    } on Exception catch (_) {
      emit(TodoModificationError());
    }
  }

  void isDoneChanger(Task task) {
    if (task.isDone) {
      task.isDone = false;
      emit(TodoIsDone());
    } else {
      task.isDone = true;
      emit(TodoIsNotDone());
    }
    todoRepository.updateTask(
      id: task.id,
      todo: task.todo,
      isDone: task.isDone,
      description: task.description,
    );
  }
}
