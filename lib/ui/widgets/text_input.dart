import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  var inputController = TextEditingController();
  String label;
  TextInput({Key? key, this.label = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: constraints.maxWidth * 7 / 8,
          height: constraints.maxWidth / 10,
          child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 248, 168, 165), width: 3),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 90, 2, 2), width: 3),
                ),
              )),
        ),
      ),
    );
  }
}
