import 'package:flutter/material.dart';
// Import Our home screen
import 'package:todoapp/Screens/ToDoMainScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo',
      home: HomeScreen(), // The Home screen widget as app home page
    );
  }
}
