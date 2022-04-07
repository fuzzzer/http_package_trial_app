import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../data/models/task.dart';
import '../../../../../data/recently_deleted_database.dart';
import '../../../../../data/repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.todoRepository) : super(TodoInitial());

  final TodoRepository todoRepository;

  void setStateToInitial() {
    emit(TodoInitial());
  }

  void loadAllTasks() async {
    emit(TodoLoading());
    try {
      var taskList = await todoRepository.fetchAllTasks();
      emit(TodoListLoaded(taskList));
    } on Exception catch (_) {
      print("load all task error");
      emit(TodoError());
    }
  }

  void loadTask(int id) async {
    emit(TodoLoading());
    try {
      Task taskInfo = await todoRepository.fetchTask(id: id.toString());
      emit(TodoLoaded(taskInfo));
    } on Exception catch (_) {
      print("loadtask error");
      emit(TodoError());
    }
  }

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
    emit(TodoLoading());
    try {
      await todoRepository.createTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      emit(TodoInitial());
    } on Exception catch (_) {
      emit(TodoError());
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
    emit(TodoLoading());
    try {
      await todoRepository.updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
    } on Exception catch (_) {
      print("update error");
      emit(TodoError());
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
