import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/schedules.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/useful_methods.dart/communicate_with_server.dart';

import '../screens/see_task.dart';

class CommandButton extends StatelessWidget {
  String cmd;
  late Future<Task> serverCmd;

  bool clicked = false;

  CommandButton({Key? key, this.cmd = ""});

  @override
  Widget build(BuildContext context) {
    final inputTextManagement = Provider.of<TextManagement>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(117, 69, 210, 235)),
          child: Text(cmd),
          onPressed: () {
            inputTextManagement
                .setidText(inputTextManagement.idInput.inputController.text);
            inputTextManagement.settodoText(
                inputTextManagement.todoInput.inputController.text);
            inputTextManagement
                .setisDone(inputTextManagement.isDoneInput.isDone);
            inputTextManagement.setdescriptionText(
                inputTextManagement.descriptionInput.inputController.text);

            inputTextManagement.goToTasksPage(context, cmd);
          }),
    );
  }
}
