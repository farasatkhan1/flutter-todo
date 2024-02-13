class Todo {
  final String id;
  final String data;

  Todo({required this.id, required this.data});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'].toString(),
      data: json['data']
    );
  }
}