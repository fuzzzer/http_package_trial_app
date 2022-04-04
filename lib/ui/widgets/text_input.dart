import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final double relativeHeight;
  final int maxLines;
  final String startingText;
  late final TextEditingController inputController;
  TextInput(
      {Key? key,
      this.label = "",
      this.relativeHeight = 1 / 15,
      this.maxLines = 1,
      this.startingText = ''})
      : super(key: key) {
    inputController = TextEditingController(text: startingText);
  }

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
                    color: Color.fromARGB(177, 93, 86, 86),
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
