import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/schedules.dart';
import '../widgets/command_button.dart';
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
    final manager = Provider.of<StateManager>(context);

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
                    idInput,
                    todoInput,
                    descriptionInput,
                    CommandButton(
                        cmd: "Add Task",
                        backgroundColor:
                            const Color.fromARGB(210, 118, 159, 108),
                        textColor: const Color.fromARGB(255, 5, 66, 49),
                        onPressedFunction: () {
                          manager.create(context,
                              idText: idInput.inputController.text,
                              todoText: todoInput.inputController.text,
                              descriptionText:
                                  descriptionInput.inputController.text);
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
