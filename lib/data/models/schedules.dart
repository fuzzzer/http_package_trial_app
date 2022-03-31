import 'package:flutter/material.dart';
import '../../ui/screens/see_task.dart';
import '../../ui/widgets/is_done_button.dart';
import '../../ui/widgets/text_input.dart';
import '../respiratoies/communicate_with_server.dart';

class TextManagement extends ChangeNotifier {
  String idText = "";
  String todoText = "";
  bool isDone = false;
  String descriptionText = "";

  TextInput idInput = TextInput(label: "id");
  TextInput todoInput = TextInput(label: "todo");
  IsDoneButton isDoneInput = IsDoneButton();
  TextInput descriptionInput = TextInput(label: "description");

  late var serverCmd;

  setTaskFields() {
    idText = idInput.inputController.text;
    todoText = todoInput.inputController.text;
    isDone = isDoneInput.isDone;
    descriptionText = descriptionInput.inputController.text;
  }

  void goToTasksPage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeeTask(serverCmd: serverCmd),
        ));

    notifyListeners();
  }

  getAll(context) {
    setTaskFields();
    serverCmd = fetchTasks();
    goToTasksPage(context);
  }

  get(context) {
    setTaskFields();
    if (int.tryParse(idText) != null) {
      serverCmd = fetchTask(id: idText);
      goToTasksPage(context);
    } else {
      print("Enter desired task id");
    }
  }

  delete(context) {
    setTaskFields();
    if (int.tryParse(idText) != null) {
      serverCmd = delateTask(id: idText);
      goToTasksPage(context);
    } else {
      print("Enter id to delete");
    }
  }

  create(context) {
    setTaskFields();
    if (int.tryParse(idText) != null) {
      serverCmd = createTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      goToTasksPage(context);
    } else {
      print("Enter id to create");
    }
  }

  update(context) {
    setTaskFields();
    if (int.tryParse(idText) != null) {
      serverCmd = updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
      goToTasksPage(context);
    } else {
      print("Enter id to update");
    }
  }
}
