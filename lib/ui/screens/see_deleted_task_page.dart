import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/data/recently_deleted_database.dart';
import 'package:to_do/ui/widgets/command_button.dart';
import 'package:to_do/ui/widgets/delete_icon_button.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';

class SeeDeletedTaskPage extends StatelessWidget {
  Task info;

  SeeDeletedTaskPage({Key? key, required this.info}) : super(key: key);

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
                    deletedTasks.remove(info);
                    manager.create(
                      context,
                      idText: info.id.toString(),
                      todoText: info.todo,
                      isDone: info.isDone,
                      descriptionText: info.description,
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
                body: info.id.toString(),
                fontSize: 20,
              ),
              TextOutput(name: "todo", body: info.todo, fontSize: 20),
              TextOutput(
                  name: "is done",
                  body: info.isDone.toString(),
                  fontSize: 20,
                  color: info.isDone ? Colors.green : Colors.red),
              TextOutput(
                name: "description ",
                body: info.description,
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
