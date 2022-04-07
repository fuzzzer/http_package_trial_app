import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/screens/add_task_page.dart';
import 'package:to_do/ui/screens/see_task_from_server_page.dart';
import '../../data/models/task.dart';
import '../../logic/todo_cubit/cubit/todo_cubit.dart';
import '../widgets/one_todo_tile.dart';
import '../widgets/start_page_drawer.dart';

class TodoStartPage extends StatelessWidget {
  const TodoStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoState>(
        bloc: context.read<TodoCubit>()..loadAllTasks(),
        builder: (context, state) {
          if (state is TodoInitial) {
            return const Center(child: Text("Initial state"));
          } else if (state is TodoLoading) {
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
                      height: 85,
                      onLongPressFunction: () {
                        //1) --------with this code you can save last state------
                        // context
                        //     .read<TodoCubit>()
                        //     .setLastPageState(TodoListLoaded(state.taskList));
                        //----------------------------------------------------

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddTaskPage()));
                  }),
            );
          } else if (state is TodoError) {
            return const Center(
                child: Text("some data request error occurred"));
          } else if (state is TodoInitial) {
            return const Center(child: Text("it is initial"));
          }

          return const Center(
              child: Text("some state management error occurred"));
        },
      ),
    );
  }
}
