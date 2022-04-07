import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/repositories/todo_repository.dart';
import 'package:to_do/logic/todo_cubit/cubit/todo_cubit.dart';
import 'package:to_do/ui/screens/todos_start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(TodoRepository()),
      child: const MaterialApp(
        title: 'modify To do server',
        home: TodoStartPage(),
      ),
    );
  }
}
