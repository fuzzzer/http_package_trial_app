import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  String name;
  String body;
  double relativeHeight; // height relative to height of the window
  double relativeWidth = 7 / 8;
  double fontSize;
  Color color;
  Alignment alignment;

  TextOutput(
      {Key? key,
      this.name = "",
      this.body = "",
      this.relativeHeight = 1 / 15,
      this.fontSize = 15,
      this.color = Colors.black,
      this.alignment = Alignment.centerLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(left: width * (1 - relativeWidth) / 2),
              alignment: Alignment.bottomLeft,
              child: Title(
                  color: Colors.black,
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ))),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width: width * relativeWidth,
              height: height * relativeHeight,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    alignment: alignment,
                    child: Text(
                      body,
                      style: TextStyle(fontSize: fontSize, color: color),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
