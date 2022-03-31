import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/models/schedules.dart';
import 'ui/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'modify To do server',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: ((context) => TextManagement()),
        child: HomePage(
          title: 'Tasks to do',
        ),
      ),
    );
  }
}
