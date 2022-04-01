import 'package:flutter/material.dart';
import 'package:to_do/data/models/task.dart';
import 'package:to_do/ui/screens/update_task_page.dart';
import '../../ui/screens/add_task_page.dart';
import '../../ui/screens/see_task_page.dart';
import '../../ui/screens/todos_start_page.dart';
import '../../ui/widgets/is_done_button.dart';
import '../../ui/widgets/text_input.dart';
import '../respiratoies/communicate_with_server.dart';

class StateManager extends ChangeNotifier {
  String idText = "";
  String todoText = "";
  bool isDone = false;
  String descriptionText = "";

  TextInput idInput = TextInput(label: "id");
  TextInput todoInput = TextInput(label: "todo");
  IsDoneButton isDoneInput = IsDoneButton();
  TextInput descriptionInput =
      TextInput(label: "description", relativeHeight: 1 / 5, maxLines: 50);

  late var serverCmd;

  setTaskFields() {
    idText = idInput.inputController.text;
    todoText = todoInput.inputController.text;
    isDone = isDoneInput.isDone;
    descriptionText = descriptionInput.inputController.text;
  }

  void goToTaskPage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeTaskPage(serverCmd: serverCmd),
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
        context, MaterialPageRoute(builder: (context) => const AddTaskPage()));

    notifyListeners();
  }

  void goToTaskUpdatePage(context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateTaskPage(info: task)),
    );

    notifyListeners();
  }

  get(context, getWithId) {
    serverCmd = fetchTask(id: getWithId.toString());
    goToTaskPage(context);
  }

  delete(context, deleteWithId) {
    setTaskFields();
    serverCmd = delateTask(id: deleteWithId);
    goToHomePage(context);
  }

  create(context) {
    setTaskFields();
    if (int.tryParse(idText) != null) {
      serverCmd = createTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      goToHomePage(context);
    } else {
      print("Enter id to create");
    }

    idInput.inputController.clear();
    todoInput.inputController.clear();
    descriptionInput.inputController.clear();
  }

  update(context) {
    setTaskFields();
    if (int.tryParse(idText) != null) {
      serverCmd = updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      goToTaskPage(context);
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
