import 'package:flutter/material.dart';
import 'package:to_do/data/models/task.dart';
import 'package:to_do/data/recently_deleted_database.dart';
import 'package:to_do/ui/screens/update_task_page.dart';
import '../../ui/screens/add_task_page.dart';
import '../../ui/screens/see_deleted_task_page.dart';
import '../../ui/screens/see_task_from_server_page.dart';
import '../../ui/screens/todos_start_page.dart';
import '../respiratoies/communicate_with_server.dart';

class StateManager extends ChangeNotifier {
  void goToSeeDeletedTaskPage(context, info) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeDeletedTaskPage(info: info),
        ));
    notifyListeners();
  }

  void goToSeeTaskFromServerPage(context, var fetchCmd) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeTaskFromServerPage(fetchCmd: fetchCmd),
        ));
    notifyListeners();
  }

  void goToHomePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoStartPage()));

    notifyListeners();
  }

  void goToAddTaskPage(context, StateManager manager) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskPage()));

    notifyListeners();
  }

  void goToTaskUpdatePage(context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateTaskPage(info: task)),
    );

    notifyListeners();
  }

  get(context, int getWithId) {
    var fetchCmd = fetchTask(id: getWithId.toString());
    goToSeeTaskFromServerPage(context, fetchCmd);
  }

  void delete(context, Task info) {
    delateTask(id: info.id.toString());
    goToHomePage(context);
    saveDeleted(info);
  }

  void saveDeleted(Task info) {
    deletedTasks.add(info);
  }

  create(
    context, {
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
  }) {
    // this will make sure that if task already exists it wont be created again
    fetchTask(id: idText)
        .then((val) => print("Enter Not existent id to create"))
        .catchError((val) {
      if (int.tryParse(idText) != null) {
        createTask(
            id: int.parse(idText),
            todo: todoText,
            isDone: isDone,
            description: descriptionText);
        goToHomePage(context);
      } else {
        print("Enter id to create");
      }
    });
  }

  updateAndShow(
    context, {
    String idText = "",
    String todoText = "",
    bool isDone = false,
    String descriptionText = "",
  }) {
    if (int.tryParse(idText) != null) {
      updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);

      var fetchCmd = fetchTask(
        id: idText,
      );
      goToSeeTaskFromServerPage(context, fetchCmd);
    } else {
      print("Enter id to update");
    }
  }

  isDoneChanger(Task task) {
    if (task.isDone) {
      task.isDone = false;
      updateTask(
        id: task.id,
        todo: task.todo,
        isDone: task.isDone,
        description: task.description,
      );
    } else {
      task.isDone = true;
      updateTask(
        id: task.id,
        todo: task.todo,
        isDone: task.isDone,
        description: task.description,
      );
    }
    notifyListeners();
  }
}
