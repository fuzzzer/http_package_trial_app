import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/screens/add_task_page.dart';
import 'package:to_do/ui/screens/see_task_from_server_page.dart';
import '../../data/models/task.dart';
import '../../logic/cubits/cubit/todo_cubit/cubit/todo_cubit.dart';
import '../widgets/one_todo_tile.dart';
import '../widgets/start_page_drawer.dart';

class TodoStartPage extends StatelessWidget {
  const TodoStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      height: height,
      child: Scaffold(
        body: BlocBuilder<TodoCubit, TodoState>(
          bloc: context.read<TodoCubit>()..loadAllTasks(),
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoListLoaded) {
              return Scaffold(
                appBar: AppBar(backgroundColor: Colors.black),
                drawer: const StartPageDrawer(),
                body: ListView.builder(
                    itemCount: state.taskList.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      Task taskInfo = state.taskList[index];
                      return ListTile(
                          title: ToDoTile(
                        taskInfo: taskInfo,
                        height: height / 10,
                        onLongPressFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SeeTaskFromServerPage(id: taskInfo.id)));
                        },
                        checkPress: () {},
                      ));
                    }),
                floatingActionButton: FloatingActionButton(
                    elevation: 5,
                    focusElevation: 20,
                    backgroundColor: const Color.fromARGB(225, 245, 213, 118),
                    focusColor: const Color.fromARGB(255, 105, 233, 93),
                    child: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTaskPage()));
                    }),
              );
            } else if (state is TodoError) {
              print("some start page error occurred");
              return const Center(
                  child: Text("some start page error occurred"));
            } else if (state is TodoLoaded) {
              print("some todo task loaded error!! occurred");
              return const Center(
                  child: Text("some todo task loaded!!!! error occurred"));
            } else if (state is TodoIsDone) {
              print("some is done error occurred");
              return const Center(child: Text("some is done error occurred"));
            }
            return const Center(child: Text("some is not done error occurred"));
          },
        ),
      ),
    );
  }
}
