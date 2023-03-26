import 'package:flutter/material.dart';
import 'package:to_do/data/recently_deleted_database.dart';
import '../../data/models/task.dart';
import '../screens/see_deleted_task_page.dart';
import 'todo_tile.dart';

class StartPageDrawer extends StatelessWidget {
  final double drawerWidthRatio;
  const StartPageDrawer({Key? key, this.drawerWidthRatio = 2 / 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * drawerWidthRatio;

    return SizedBox(
        width: width,
        child: Drawer(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Recently deleted tasks",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    deletedTasks.isEmpty
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: deletedTasks.length,
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  int listMemberCoefficient =
                                      deletedTasks.length - index - 1;
                                  Task taskInfo =
                                      deletedTasks[listMemberCoefficient];
                                  return ListTile(
                                    title: TodoTile(
                                      taskInfo: taskInfo,
                                      height: width / 4,
                                      onLongPressFunction: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SeeDeletedTaskPage(
                                                    taskInfo: taskInfo),
                                          )),
                                      checkPress: null,
                                    ),
                                  );
                                }),
                          ),
                  ])),
        ));
  }
}
