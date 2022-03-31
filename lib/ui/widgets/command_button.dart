import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/schedules.dart';

class CommandButton extends StatelessWidget {
  String cmd;
  Function onPressedFunction;

  bool clicked = false;

  CommandButton({
    Key? key,
    this.cmd = "",
    required this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Color.fromARGB(117, 22, 26, 23)),
        child: Text(cmd),
        onPressed: () {
          onPressedFunction(context);
        },
      ),
    );
  }
}
