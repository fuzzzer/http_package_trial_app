import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/repositories/todo_repository.dart';
import '../../data/models/task.dart';
import '../../logic/cubits/todo_modification_cubit copy/todo_modification_cubit.dart';

class TodoTile extends StatelessWidget {
  final Task taskInfo;
  final double height;
  final Function onLongPressFunction;
  final Function? checkPress;
  late final bool canBeChecked;

  TodoTile(
      {Key? key,
      required this.taskInfo,
      this.height = 100,
      required this.onLongPressFunction,
      required this.checkPress})
      : super(key: key) {
    if (checkPress != null) {
      canBeChecked = true;
    } else {
      canBeChecked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoModificationCubit(TodoRepository()),
      child: SizedBox(
        height: height,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onLongPress: () => onLongPressFunction(),
          splashFactory: InkSplash.splashFactory,
          radius: 10,
          highlightColor: const Color.fromARGB(142, 95, 170, 232),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(taskInfo.todo))),
                canBeChecked
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BlocBuilder<TodoModificationCubit,
                            TodoModificationState>(
                          builder: (context, state) {
                            return Checkbox(
                                checkColor: Colors.black,
                                activeColor:
                                    const Color.fromARGB(200, 149, 219, 153),
                                value: taskInfo.isDone,
                                onChanged: (done) {
                                  context
                                      .read<TodoModificationCubit>()
                                      .isDoneChanger(taskInfo);
                                });
                          },
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
