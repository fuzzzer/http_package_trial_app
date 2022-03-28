import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedules.dart';
import '../../models/task.dart';
import '../widgets/get_data_button.dart';

class HomePage extends StatelessWidget {
  String title;

  HomePage({
    Key? key,
    this.title = "",
  }) : super(key: key);

  Future<Task>? serverResponse;

  @override
  Widget build(BuildContext context) {
    final inputTextManagement = Provider.of<TextManagement>(context);

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
              inputTextManagement.idInput,
              inputTextManagement.todoInput,
              inputTextManagement.isDoneInput,
              inputTextManagement.descriptionInput,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CommandButton(
                      cmd: "Get All",
                    ),
                  ),
                  Expanded(
                      child: CommandButton(
                    cmd: "Get",
                  )),
                  Expanded(
                    child: CommandButton(
                      cmd: "Delete",
                    ),
                  ),
                  Expanded(
                    child: CommandButton(
                      cmd: "Create",
                    ),
                  ),
                  Expanded(
                    child: CommandButton(
                      cmd: "Update",
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
