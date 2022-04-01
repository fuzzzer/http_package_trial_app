import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/screens/todos_start_page.dart';
import 'data/models/schedules.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => StateManager()),
      builder: (context, child) => MaterialApp(
        title: 'modify To do server',
        home: TodoStartPage(),
      ),
    );
  }
}
