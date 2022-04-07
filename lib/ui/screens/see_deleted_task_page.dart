import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubits/cubit/todo_cubit/cubit/todo_cubit.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/task.dart';
import 'todos_start_page.dart';

class SeeDeletedTaskPage extends StatelessWidget {
  final Task taskInfo;

  const SeeDeletedTaskPage({Key? key, required this.taskInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      height: height,
      child: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: SizedBox(
                    height: 5,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<TodoCubit>().addTask(
                              idText: taskInfo.id.toString(),
                              todoText: taskInfo.todo,
                              isDone: taskInfo.isDone,
                              descriptionText: taskInfo.description,
                            );
                        context
                            .read<TodoCubit>()
                            .removeTaskFromRecentlyDeleted(taskInfo);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TodoStartPage()));
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
          );
        },
      ),
    );
  }
}
