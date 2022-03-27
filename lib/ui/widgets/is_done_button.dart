import 'package:flutter/material.dart';

class IsDoneButton extends StatefulWidget {
  bool isDone = false;

  IsDoneButton({Key? key}) : super(key: key);

  @override
  State<IsDoneButton> createState() => _IsDoneButtonState();
}

class _IsDoneButtonState extends State<IsDoneButton> {
  void onPressedFunction() {
    if (widget.isDone == false) {
      setState(() {
        widget.isDone = true;
      });
    } else {
      setState(() {
        widget.isDone = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: constraints.maxWidth * 7 / 8,
          height: constraints.maxWidth / 10,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: widget.isDone ? Colors.green : Colors.red),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "isDone?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.isDone ? "Yes" : "No",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            onPressed: onPressedFunction,
          ),
        ),
      ),
    );
  }
}
