import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubits/cubit/todo_start_page_cubit.dart';
import '../../data/models/task.dart';
import '../../data/respiratoies/todo_repository.dart';
import '../widgets/one_todo_tile.dart';
import '../widgets/start_page_drawer.dart';

class TodoStartPage extends StatelessWidget {
  final serverCmd = TodoRepository().fetchAllTasks();

  TodoStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => TodoStartPageCubit(TodoRepository()),
      child: SizedBox(
        width: width,
        height: height,
        child: Scaffold(
          body: BlocBuilder<TodoStartPageCubit, TodoStartPageState>(
            builder: (context, state) {
              if (state is TodoStartPageInitial) {
                context
                    .watch<TodoStartPageCubit>()
                    .loadAllTodos(); // is watch used because we want to change state and rebuild after fetchAllTasks returns result?
                return const Center();
              } else if (state is TodoStartPageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodoStartPageLoaded) {
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
                            context
                                .read<TodoStartPageCubit>()
                                .goToSeeTaskFromServerPage(
                                    context, taskInfo.id);
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
                    onPressed: () => context
                        .read<TodoStartPageCubit>()
                        .goToAddTaskPage(context),
                  ),
                );
              } else {
                return const Center(child: Text("some error occurred"));
              }
            },
          ),
        ),
      ),
    );
  }
}
