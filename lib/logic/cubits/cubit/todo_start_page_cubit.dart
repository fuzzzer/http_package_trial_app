import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:to_do/data/models/task.dart';
import 'package:to_do/data/respiratoies/todo_repository.dart';
import '../../../ui/screens/add_task_page.dart';
import '../../../ui/screens/see_task_from_server_page.dart';

part 'todo_start_page_state.dart';

class TodoStartPageCubit extends Cubit<TodoStartPageState> {
  TodoStartPageCubit(this.todoRepository)
      : super(
            TodoStartPageInitial()); // we use super because we want to start watching todoStartPageCubit from the class which is passed as an argument

  final TodoRepository todoRepository;

  void loadAllTodos() async {
    emit(TodoStartPageLoading());
    try {
      var taskList = await todoRepository.fetchAllTasks();
      emit(TodoStartPageLoaded(taskList));
    } on Exception catch (_) {
      emit(TodoStartPageError());
    }
  }

  void goToSeeTaskFromServerPage(context, int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeTaskFromServerPage(id: id),
        ));
  }

  void goToAddTaskPage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskPage()));
  }
}
