import 'package:flutter/material.dart';
import '../../data/models/schedules.dart';

class DeleteButton extends StatelessWidget {
  final StateManager manager;
  final String id;
  final Function onDeletePress;
  const DeleteButton(
      {Key? key,
      required this.manager,
      required this.id,
      required this.onDeletePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
        size: 30,
      ),
      iconSize: 30,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
              "Are you sure?",
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDeletePress();
                },
                child: const Text('delete',
                    style: TextStyle(
                        color: Color.fromARGB(255, 242, 7, 7),
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        );
      },
    );
  }
}
