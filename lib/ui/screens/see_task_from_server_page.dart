import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/screens/todos_start_page.dart';
import 'package:to_do/ui/screens/update_task_page.dart';
import 'package:to_do/ui/widgets/delete_icon_button.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/task.dart';
import '../../logic/todo_cubit/cubit/todo_cubit.dart';

class SeeTaskFromServerPage extends StatelessWidget {
  final int id;

  const SeeTaskFromServerPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<TodoCubit, TodoState>(
          bloc: context.read<TodoCubit>()..loadTask(id),
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoLoaded) {
              Task taskInfo = state.taskInfo;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // with this todo_start_page rebuilds causing more inneficient code,
                      // without custom go back function state was stuck on TodoLoaded
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const TodoStartPage()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  actions: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      child: SizedBox(
                        width: 80,
                        height: 5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateTaskPage(taskInfo: taskInfo)),
                            );
                          },
                          child: const Text("Edit"),
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(159, 235, 190, 56)),
                        ),
                      ),
                    ),
                    DeleteButton(
                      id: taskInfo.id.toString(),
                      onDeletePress: () {
                        context.read<TodoCubit>().deleteTask(taskInfo);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const TodoStartPage()),
                            (Route<dynamic> route) => false);
                      },
                    )
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
                      TextOutput(
                          name: "todo", body: taskInfo.todo, fontSize: 20),
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
              );
            } else if (state is TodoError) {
              return const Center(
                  child: Text("some data request error occurred"));
            }
            return const Center(
                child: Text("some state management error occurred"));
          },
        ),
      ),
    );
  }
}
