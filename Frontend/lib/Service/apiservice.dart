import 'dart:convert';
// Import the client from the Http Packages
import 'package:http/http.dart' show Client;
//Import the Todo Model
import 'package:todoapp/models/todo.dart';

class ApiService {
  // Replace this with your computer's IP Address
  final String _baseUrl = "http://10.0.2.2:5000/api";
  Client client = Client();
// Get All Todos
  Future<List<Todo>> getTodos() async {
    try {
      final response = await client.get(Uri.parse('$_baseUrl/ToDo'));
      if (response.statusCode == 200) {
        final todos = jsonDecode(response.body) as List;
        return todos.map((todo) => Todo.fromJson(todo)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      print("Exception throuwn $e");
    }
    throw 'Todo';
  }

  //Add a ToDo

  Future<bool> addTodo(Todo data) async {
    final response = await client.post(Uri.parse('$_baseUrl/Todo'),
        headers: {"content-type": "application/json"}, body: data.toJson(data));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  //Delete a ToDo
  Future<bool> deleteTodo(int todoid) async {
    final response = await client.delete(Uri.parse('$_baseUrl/ToDo/$todoid'));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  // Update an existing Todo
  Future<bool> updateToDo(Todo data) async {
    final response = await client.put(
      Uri.parse("$_baseUrl/ToDo/${data.id}"),
      headers: {"content-type": "application/json"},
      body: data.toJson(data),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
