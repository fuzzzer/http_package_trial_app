import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';
import '../widgets/command_button.dart';
import '../widgets/text_input.dart';

class UpdateTaskPage extends StatelessWidget {
  final Task info;
  const UpdateTaskPage({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final manager = Provider.of<StateManager>(context);

    TextInput todoInput = TextInput(
      label: "todo",
      startingText: info.todo,
    );
    TextInput descriptionInput = TextInput(
        label: "description",
        startingText: info.description,
        relativeHeight: 1 / 5,
        maxLines: 50);

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
          body: Consumer(
            builder: (context, value, child) => Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextOutput(
                      name: "id",
                      body: info.id.toString(),
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
                          manager.updateAndShow(
                            context,
                            idText: info.id.toString(),
                            todoText: todoInput.inputController.text,
                            isDone: info.isDone,
                            descriptionText:
                                descriptionInput.inputController.text,
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
