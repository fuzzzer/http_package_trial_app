import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/schedules.dart';
import '../widgets/command_button.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final manager = Provider.of<StateManager>(context);

    return SizedBox(
      width: width,
      height: height,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Consumer(
          builder: (context, value, child) => Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  manager.idInput,
                  manager.todoInput,
                  manager.descriptionInput,
                  CommandButton(
                    cmd: "Add Task",
                    onPressedFunction: manager.create,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
