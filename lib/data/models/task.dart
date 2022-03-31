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
