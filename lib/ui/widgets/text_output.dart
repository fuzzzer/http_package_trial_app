import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String name;
  final String body;
  final double relativeHeight; // height relative to height of the window
  final double relativeWidth;
  final double fontSize;
  final Color color;
  final Alignment textAlignment;
  final FontWeight fontWeight;
  final Color backgroundColor;

  const TextOutput(
      {Key? key,
      this.name = "",
      this.body = "",
      this.relativeWidth = 7 / 8,
      this.relativeHeight = 1 / 15,
      this.fontSize = 15,
      this.color = Colors.black,
      this.textAlignment = Alignment.centerLeft,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = const Color.fromARGB(24, 141, 129, 129)})
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
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
                  child: Container(
                    alignment: textAlignment,
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
