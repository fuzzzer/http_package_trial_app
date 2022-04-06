import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubits/cubit/update_task_page_cubit.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/task.dart';
import '../../data/respiratoies/todo_repository.dart';
import '../widgets/command_button.dart';
import '../widgets/text_input.dart';

class UpdateTaskPage extends StatelessWidget {
  final Task taskInfo;
  const UpdateTaskPage({Key? key, required this.taskInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    TextInput todoInput = TextInput(
      label: "todo",
      startingText: taskInfo.todo,
    );
    TextInput descriptionInput = TextInput(
        label: "description",
        startingText: taskInfo.description,
        relativeHeight: 1 / 5,
        maxLines: 50);

    return BlocProvider(
      create: (context) => UpdateTaskPageCubit(TodoRepository()),
      child: SizedBox(
        width: width,
        height: height,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: BlocBuilder<UpdateTaskPageCubit, UpdateTaskPageState>(
              builder: (context, state) {
                if (state is UpdateTaskPageInitial) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextOutput(
                          name: "id",
                          body: taskInfo.id.toString(),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        todoInput,
                        descriptionInput,
                        CommandButton(
                            cmd: "update",
                            backgroundColor:
                                const Color.fromARGB(210, 118, 159, 108),
                            textColor: const Color.fromARGB(255, 5, 66, 49),
                            onPressedFunction: () {
                              context.read<UpdateTaskPageCubit>().updateAndShow(
                                    context,
                                    idText: taskInfo.id.toString(),
                                    todoText: todoInput.inputController.text,
                                    isDone: taskInfo.isDone,
                                    descriptionText:
                                        descriptionInput.inputController.text,
                                  );
                            }),
                      ],
                    ),
                  );
                } else if (state is UpdateTaskPageUpdateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text("some error occured"));
              },
            ),
          ),
        ),
      ),
    );
  }
}
