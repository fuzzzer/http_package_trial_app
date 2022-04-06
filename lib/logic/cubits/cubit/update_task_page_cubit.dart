import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:to_do/data/respiratoies/todo_repository.dart';

import '../../../ui/screens/todos_start_page.dart';

part 'update_task_page_state.dart';

class UpdateTaskPageCubit extends Cubit<UpdateTaskPageState> {
  final TodoRepository todoRepository;
  UpdateTaskPageCubit(this.todoRepository) : super(UpdateTaskPageInitial());

  void goToHomePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoStartPage()));
  }

  updateAndShow(
    context, {
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
  }) async {
    emit(UpdateTaskPageUpdateLoading());
    try {
      await todoRepository.updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      goToHomePage(context);
    } on Exception catch (_) {
      emit(UpdateTaskPageError());
    }
  }
}
