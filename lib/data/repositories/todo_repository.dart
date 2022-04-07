import 'package:dio/dio.dart';

import '../../core/app_properties.dart';
import '../models/task.dart';

class TodoRepository {
  final _dio = Dio();

  Future<List<Task>> fetchAllTasks() async {
    final response = await _dio.get('http://$localHost:8080/todos');

    var result = <Task>[];

    try {
      if (response.statusCode == 200) {
        var decodedList = response.data;

        for (var task in decodedList) {
          var classifiedTask = Task.fromJson(task);
          result.add(classifiedTask);
        }
      }
    } catch (error) {
      throw Exception("Failed to fetch task data");
    }

    return result;
  }

  Future<Task> fetchTask({required String id}) async {
    final response = await _dio.get('http://$localHost:8080/todo/$id');

    Task result = Task(
        id: -1,
        todo: "failed task",
        isDone: false,
        description: "this is returned because task data was not fetched");

    if (response.statusCode == 200) {
      result = Task.fromJson(response.data);
    } else {
      throw Exception("Failed to fetch task data");
    }

    return result;
  }

  Future<bool> delateTask({required String id}) async {
    final response =
        await _dio.delete('http://$localHost:8080/delete-todo/$id');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete Task');
    }
  }

  Future<bool> createTask(
      {required int id,
      String todo = "No name",
      bool isDone = false,
      String description = "No description"}) async {
    final response = await _dio.post(
      'http://$localHost:8080/add-todo',
      data: {
        'id': id,
        'todo': todo,
        'isDone': isDone,
        'description': description,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create Task!');
    }
  }

  Future<bool> updateTask(
      {required int id,
      String todo = "No name",
      bool isDone = false,
      String description = "No description"}) async {
    final response =
        await _dio.put('http://$localHost:8080/update-todo', data: {
      'id': id,
      'todo': todo,
      'isDone': isDone,
      'description': description,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update Task');
    }
  }
}
