import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';
import '../widgets/command_button.dart';

class HomePage extends StatelessWidget {
  String title;

  HomePage({
    Key? key,
    this.title = "",
  }) : super(key: key);

  Future<Task>? serverResponse;

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<TextManagement>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 70, 69, 69),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(child: Text(title)),
        ),
        body: Consumer(
          builder: (context, value, child) => Column(
            children: [
              manager.idInput,
              manager.todoInput,
              manager.isDoneInput,
              manager.descriptionInput,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CommandButton(
                      cmd: "Get All",
                      onPressedFunction: manager.getAll,
                    ),
                  ),
                  Expanded(
                      child: CommandButton(
                    cmd: "Get",
                    onPressedFunction: manager.get,
                  )),
                  Expanded(
                    child: CommandButton(
                      cmd: "Delete",
                      onPressedFunction: manager.delete,
                    ),
                  ),
                  Expanded(
                    child: CommandButton(
                      cmd: "Create",
                      onPressedFunction: manager.create,
                    ),
                  ),
                  Expanded(
                    child: CommandButton(
                      cmd: "Update",
                      onPressedFunction: manager.update,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
