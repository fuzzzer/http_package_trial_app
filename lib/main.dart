import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/repositories/todo_repository.dart';
import 'package:to_do/logic/cubits/todo_cubit/todo_cubit.dart';
import 'package:to_do/ui/screens/todos_start_page.dart';

import 'logic/cubits/todo_list_cubit/todo_list_cubit.dart';
import 'logic/cubits/todo_modification_cubit copy/todo_modification_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoCubit(TodoRepository()),
        ),
        BlocProvider(
          create: (context) => TodoListCubit(TodoRepository()),
        ),
        BlocProvider(
          create: (context) => TodoModificationCubit(TodoRepository()),
        ),
      ],
      child: const MaterialApp(
        title: 'modify To do server',
        home: TodoStartPage(),
      ),
    );
  }
}
