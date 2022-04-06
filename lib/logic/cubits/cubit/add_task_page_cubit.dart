import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/respiratoies/todo_repository.dart';
import '../../../ui/screens/todos_start_page.dart';
part 'add_task_page_state.dart';

class AddTaskPageCubit extends Cubit<AddTaskPageState> {
  final TodoRepository todoRepository;

  AddTaskPageCubit(this.todoRepository) : super(AddTaskPageInitial());

  void goToHomePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoStartPage()));
  }

  void checkIDAndAddNewTask({
    required context,
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
    var existentIdDialog,
  }) async {
    try {
      await todoRepository
          .fetchTask(id: idText)
          .then((value) => existentIdDialog());
    } on Exception catch (_) {
      addNewTask(
        context: context,
        idText: idText,
        todoText: todoText,
        isDone: isDone,
        descriptionText: descriptionText,
      );
    }
  }

  void addNewTask({
    required context,
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
  }) async {
    emit(AddTaskPageLoading());
    try {
      await todoRepository.createTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      goToHomePage(context);
    } on Exception catch (_) {
      emit(AddTaskPageError());
    }
  }
}
