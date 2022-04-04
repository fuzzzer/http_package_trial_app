import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/widgets/delete_icon_button.dart';
import 'package:to_do/ui/widgets/text_output.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';

class SeeTaskFromServerPage extends StatelessWidget {
  final Future<Task> fetchCmd;

  const SeeTaskFromServerPage({Key? key, required this.fetchCmd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final manager = Provider.of<StateManager>(context);

    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: FutureBuilder<Task>(
          future: fetchCmd,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Task info = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    actions: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        child: SizedBox(
                          width: width / 5,
                          height: 5,
                          child: ElevatedButton(
                            onPressed: () {
                              manager.goToTaskUpdatePage(
                                  context, snapshot.data!);
                            },
                            child: const Text("Edit"),
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(159, 235, 190, 56)),
                          ),
                        ),
                      ),
                      DeleteButton(
                        manager: manager,
                        id: info.id.toString(),
                        onDeletePress: () {
                          manager.delete(context, info);
                        },
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextOutput(
                          name: "id",
                          body: snapshot.data!.id.toString(),
                          fontSize: 20,
                        ),
                        TextOutput(
                            name: "todo",
                            body: snapshot.data!.todo,
                            fontSize: 20),
                        TextOutput(
                            name: "is done",
                            body: snapshot.data!.isDone.toString(),
                            fontSize: 20,
                            color: snapshot.data!.isDone
                                ? Colors.green
                                : Colors.red),
                        TextOutput(
                          name: "description ",
                          body: snapshot.data!.description,
                          relativeHeight: 1 / 5,
                          textAlignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
