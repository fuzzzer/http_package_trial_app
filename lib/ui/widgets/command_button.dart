import 'package:flutter/material.dart';

class CommandButton extends StatelessWidget {
  final String cmd;
  final Function onPressedFunction;

  bool clicked = false;

  CommandButton({
    Key? key,
    this.cmd = "",
    required this.onPressedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10, primary: const Color.fromARGB(210, 118, 159, 108)),
        child: Text(
          cmd,
          style: const TextStyle(
              color: Color.fromARGB(255, 5, 66, 49),
              fontWeight: FontWeight.w800),
        ),
        onPressed: () {
          onPressedFunction(context);
        },
      ),
    );
  }
}
