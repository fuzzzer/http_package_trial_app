import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/logic/cubits/cubit/add_task_page_cubit.dart';
import '../../data/respiratoies/todo_repository.dart';
import '../widgets/command_button.dart';
import '../widgets/message_dialog.dart';
import '../widgets/text_input.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({
    Key? key,
  }) : super(key: key);

  final TextInput idInput = TextInput(label: "id");
  final TextInput todoInput = TextInput(label: "todo");
  final TextInput descriptionInput =
      TextInput(label: "description", relativeHeight: 1 / 5, maxLines: 50);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => AddTaskPageCubit(TodoRepository()),
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
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: BlocBuilder<AddTaskPageCubit, AddTaskPageState>(
              builder: (context, state) {
                if (state is AddTaskPageInitial) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          idInput,
                          todoInput,
                          descriptionInput,
                          CommandButton(
                              cmd: "Add Task",
                              backgroundColor:
                                  const Color.fromARGB(210, 118, 159, 108),
                              textColor: const Color.fromARGB(255, 5, 66, 49),
                              onPressedFunction: () {
                                int.tryParse(idInput.inputController.text) ==
                                        null
                                    ? messageDialog(context,
                                        message: "Enter id to create new todo!",
                                        answer: "OK")
                                    : context
                                        .read<AddTaskPageCubit>()
                                        .checkIDAndAddNewTask(
                                            context: context,
                                            existentIdDialog: () => messageDialog(
                                                context,
                                                message:
                                                    "Enter Not existent id to create new todo!",
                                                answer: "OK"),
                                            idText:
                                                idInput.inputController.text,
                                            todoText:
                                                todoInput.inputController.text,
                                            descriptionText: descriptionInput
                                                .inputController.text);
                              }),
                        ],
                      ),
                    ),
                  );
                } else if (state is AddTaskPageLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text("some error occurred"));
              },
            ),
          ),
        ),
      ),
    );
  }
}
