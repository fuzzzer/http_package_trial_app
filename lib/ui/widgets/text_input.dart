import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  var inputController = TextEditingController();
  String label;
  double relativeHeight;
  int maxLines;
  TextInput(
      {Key? key,
      this.label = "",
      this.relativeHeight = 1 / 15,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: width * 7 / 8,
        height: height * relativeHeight,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          shadowColor: Colors.blue,
          child: SizedBox(
            height: double.infinity,
            child: TextField(
                maxLines: maxLines,
                controller: inputController,
                decoration: InputDecoration(
                  labelText: label,
                  alignLabelWithHint: true,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(210, 0, 0, 0), width: 1.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(155, 69, 152, 229), width: 1.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
