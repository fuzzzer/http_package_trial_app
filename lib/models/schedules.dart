import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import '../ui/screens/see_task.dart';
import '../ui/widgets/is_done_button.dart';
import '../ui/widgets/text_input.dart';
import '../useful_methods.dart/communicate_with_server.dart';

class TextManagement extends ChangeNotifier {
  String idText = "";
  String todoText = "";
  bool isDone = false;
  String descriptionText = "";

  TextInput idInput = TextInput(label: "id");
  TextInput todoInput = TextInput(label: "todo");
  IsDoneButton isDoneInput = IsDoneButton();
  TextInput descriptionInput = TextInput(label: "description");

  void setidText(String text) {
    idText = text;
  }

  void settodoText(String text) {
    todoText = text;
  }

  void setisDone(bool) {
    isDone = bool;
  }

  void setdescriptionText(String text) {
    descriptionText = text;
  }

  void goToTasksPage(context, String cmd) {
    late var serverCmd = establishCorrectServerCmd(cmd);

    if (cmd == "Get All" ||
        int.tryParse(idInput.inputController.text) != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SeeTask(serverCmd: serverCmd, cmd: cmd)),
      );
    } else {
      print("Enter id");
    }

    notifyListeners();
  }

  establishCorrectServerCmd(String cmd) {
    if (cmd == "Get All") {
      return fetchTasks();
    }
    if (cmd == "Get") {
      return fetchTask(id: idText);
    }
    if (cmd == "Delete") {
      return delateTask(id: idText);
    }
    if (cmd == "Create") {
      return createTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
    }
    if (cmd == "Update") {
      return updateTask(
          id: int.parse(idText),
          todo: todoText,
          isDone: isDone,
          description: descriptionText);
    }

    return Future<Task>.error('InCorrect Command');
  }
}
