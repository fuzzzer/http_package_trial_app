import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/data/respiratoies/communicate_with_server.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';
import '../widgets/one_todo_tile.dart';
import '../widgets/start_page_drawer.dart';

class TodoStartPage extends StatelessWidget {
  final serverCmd = fetchAllTasks();

  TodoStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StateManager manager = Provider.of<StateManager>(context);

    return SizedBox(
        width: width,
        height: height,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(backgroundColor: Colors.black),
          drawer: const StartPageDrawer(),
          body: FutureBuilder<List<Task>>(
            future: serverCmd,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        Task taskInfo = snapshot.data![index];
                        return ListTile(
                            title: ToDoTile(
                          taskInfo: taskInfo,
                          height: height / 10,
                          onLongPressFunction: () {
                            manager.get(context, taskInfo.id);
                          },
                          checkPress: () => manager.isDoneChanger(taskInfo),
                        ));
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 5,
            focusElevation: 20,
            backgroundColor: const Color.fromARGB(225, 245, 213, 118),
            focusColor: const Color.fromARGB(255, 105, 233, 93),
            child: const Icon(Icons.add),
            onPressed: () => manager.goToAddTaskPage(context, manager),
          ),
        ));
  }
}
