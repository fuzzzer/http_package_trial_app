import 'package:flutter/material.dart';

class CommandButton extends StatelessWidget {
  final String cmd;
  final Function onPressedFunction;
  final Color backgroundColor;
  final Color textColor;

  CommandButton(
      {Key? key,
      this.cmd = "",
      required this.onPressedFunction,
      this.backgroundColor = Colors.white,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 10, primary: backgroundColor),
        child: Text(
          cmd,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
        ),
        onPressed: () => onPressedFunction(),
      ),
    );
  }
}
