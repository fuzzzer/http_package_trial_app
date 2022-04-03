import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/schedules.dart';
import '../../data/models/task.dart';

class ToDoTile extends StatelessWidget {
  Task taskInfo;
  double height;
  Function onLongPressFunction;
  Function? checkPress;
  late bool canBeChecked;

  ToDoTile(
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
    final manager = Provider.of<StateManager>(context);
    return SizedBox(
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
                      child: Checkbox(
                          checkColor: Colors.black,
                          activeColor: const Color.fromARGB(200, 149, 219, 153),
                          value: taskInfo.isDone,
                          onChanged: (done) {
                            checkPress!();
                          }),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
