import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/data/recently_deleted_database.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';

class SeeDeletedTaskPage extends StatelessWidget {
  Task taskInfo;

  SeeDeletedTaskPage({Key? key, required this.taskInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final manager = Provider.of<StateManager>(context);

    return SizedBox(
      width: width,
      height: height,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: SizedBox(
                height: 5,
                child: ElevatedButton(
                  onPressed: () {
                    deletedTasks.remove(taskInfo);
                    manager.create(
                      context,
                      idText: taskInfo.id.toString(),
                      todoText: taskInfo.todo,
                      isDone: taskInfo.isDone,
                      descriptionText: taskInfo.description,
                    );
                  },
                  child: const Text("Recover"),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(159, 80, 235, 56)),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextOutput(
                name: "id",
                body: taskInfo.id.toString(),
                fontSize: 20,
              ),
              TextOutput(name: "todo", body: taskInfo.todo, fontSize: 20),
              TextOutput(
                  name: "is done",
                  body: taskInfo.isDone.toString(),
                  fontSize: 20,
                  color: taskInfo.isDone ? Colors.green : Colors.red),
              TextOutput(
                name: "description ",
                body: taskInfo.description,
                relativeHeight: 1 / 5,
                textAlignment: Alignment.topLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
