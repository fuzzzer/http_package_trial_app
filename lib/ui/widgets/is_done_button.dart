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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: width * 7 / 8,
        height: height / 11,
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
    );
  }
}
