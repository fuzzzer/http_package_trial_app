import 'package:flutter/material.dart';

Future messageDialog(
  context, {
  required String message,
  required String answer,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        message,
        style: const TextStyle(
            color: Color.fromARGB(204, 0, 0, 0),
            fontSize: 20,
            fontFamily: "Oswald",
            fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(answer,
              style: const TextStyle(
                  color: Color.fromARGB(255, 216, 123, 123),
                  fontSize: 25,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}
