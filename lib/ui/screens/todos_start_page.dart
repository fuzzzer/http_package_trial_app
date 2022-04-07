import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/screens/add_task_page.dart';
import 'package:to_do/ui/screens/see_task_from_server_page.dart';
import '../../data/models/task.dart';
import '../../logic/cubits/todo_list_cubit/todo_list_cubit.dart';
import '../widgets/todo_tile.dart';
import '../widgets/start_page_drawer.dart';

class TodoStartPage extends StatelessWidget {
  const TodoStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoListCubit, TodoListState>(
        bloc: context.read<TodoListCubit>()..loadAllTasks(),
        builder: (context, state) {
          if (state is TodoListLoading) {
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
                        title: TodoTile(
                      taskInfo: taskInfo,
                      height: 85,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddTaskPage()));
                  }),
            );
          }
          return const Center(child: Text("some request error occurred"));
        },
      ),
    );
  }
}
