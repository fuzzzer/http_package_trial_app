import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/ui/screens/todos_start_page.dart';
import '../../logic/cubits/cubit/todo_cubit/cubit/todo_cubit.dart';
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

    return SizedBox(
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
          body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
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
                        onPressedFunction: () async {
                          String idEntered = idInput.inputController.text;
                          if (int.tryParse(idEntered) == null) {
                            showDialog(
                                context: context,
                                builder: (context) => messageDialog(context,
                                    message: "Enter id to create new todo!",
                                    answer: "OK",
                                    onPressed: () => Navigator.pop(context)));
                          } else {
                            bool idIsAvailable = await context
                                .read<TodoCubit>()
                                .checkIdAvailability(idEntered);
                            if (idIsAvailable) {
                              context.read<TodoCubit>().addTask(
                                  idText: idEntered,
                                  todoText: todoInput.inputController.text,
                                  descriptionText:
                                      descriptionInput.inputController.text);

                              //navigating to startpage
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TodoStartPage()),
                                  (Route<dynamic> route) => false);
                            } else {
                              // this else statement activates if id is not available
                              showDialog(
                                context: context,
                                builder: (context) => messageDialog(
                                  context,
                                  message:
                                      "Enter Not existent id to create new todo!",
                                  answer: "OK",
                                  onPressed: () => Navigator.pop(context),
                                ),
                              );
                            }
                          }
                        }),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
