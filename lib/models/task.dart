// unComment next section

// class TaskList {
//   List<Task> tasksList;
//   TaskList(this.tasksList);

//   factory TaskList.fromJson(List<Map<String, dynamic>> json) {
//     List<Task> result = [];
//     for (int i = 0; i < json.length; i++) {
//       result.add(Task.fromJson(json[i]));
//     }
//     return TaskList(result);
//   }
// }

class Task {
  int id;
  String todo;
  bool isDone;
  String description;

  Task(
      {required this.id,
      required this.todo,
      required this.isDone,
      required this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        todo: json['todo'],
        isDone: json['isDone'],
        description: json['description']);
  }
}
