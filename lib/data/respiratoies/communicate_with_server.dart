import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do/data/models/task.dart';
import '../../app_properies.dart';

Future<List<Task>> fetchTasks() async {
  final response = await http.get(Uri.parse('http://$localHost:8080/todos'));

  var result = <Task>[];

  if (response.statusCode == 200) {
    var decodedList = jsonDecode(response.body);

    for (var task in decodedList) {
      result.add(Task.fromJson(task));
    }

    return result;
  } else {
    throw Exception("Failed to fetch task data");
  }
}

Future<Task> fetchTask({required String id}) async {
  final response = await http.get(Uri.parse('http://$localHost:8080/todo/$id'));

  if (response.statusCode == 200) {
    return Task.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch task data");
  }
}

Future<bool> delateTask({required String id}) async {
  final response = await http.delete(
    Uri.parse('http://$localHost:8080/delete-todo/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

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
  final response = await http.post(
    Uri.parse('http://$localHost:8080/add-todo'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
      <String, dynamic>{
        'id': id,
        'todo': todo,
        'isDone': isDone,
        'description': description,
      },
    ),
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
  final response = await http.put(
    Uri.parse('http://$localHost:8080/update-todo'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'id': id,
      'todo': todo,
      'isDone': isDone,
      'description': description,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to update Task');
  }
}
