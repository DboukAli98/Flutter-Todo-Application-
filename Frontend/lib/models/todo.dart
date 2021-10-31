import 'dart:convert';

class Todo {
  int id;
  String title;
  String description;
  String status;

  Todo(
      {this.id = 0,
      this.title = "",
      this.description = "",
      this.status = "Pending..."});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }

  // A helper method to convert the todo object to JSON String
  String toJson(Todo data) {
    // First we convert the object to a map
    final jsonData = data.toMap();
    // Then we encode the map as a JSON string
    return json.encode(jsonData);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "status": status
    };
  }
}
