import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/models/task.dart';
import '../../../data/recently_deleted_database.dart';
import '../../../data/respiratoies/todo_repository.dart';
import '../../../ui/screens/todos_start_page.dart';
import '../../../ui/screens/update_task_page.dart';

part 'see_task_from_server_page_state.dart';

class SeeTaskFromServerPageCubit extends Cubit<SeeTaskFromServerPageState> {
  final TodoRepository todoRepository;

  SeeTaskFromServerPageCubit(this.todoRepository)
      : super(SeeTaskFromServerPageInitial());

  void loadTodo(int id) async {
    emit(SeeTaskFromServerPageLoading());
    try {
      Task taskInfo = await todoRepository.fetchTask(id: id.toString());
      emit(SeeTaskFromServerPageLoaded(taskInfo));
    } on Exception catch (_) {
      emit(SeeTaskFromServerPageError());
    }
  }

  void goToTaskUpdatePage(context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateTaskPage(taskInfo: task)),
    );
  }

  void goToHomePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoStartPage()));
  }

  void delete(context, Task taskInfo) {
    todoRepository.delateTask(id: taskInfo.id.toString());
    saveDeleted(taskInfo);
    goToHomePage(context);
  }

  void saveDeleted(Task taskInfo) {
    deletedTasks.add(taskInfo);
  }
}
