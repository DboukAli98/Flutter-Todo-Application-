import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Service/apiservice.dart';
import 'package:todoapp/Widgets/Manage_ToDo_Widget.dart';
import 'package:todoapp/models/todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter ToDo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openManageTodoSheet(Todo(), context),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openManageTodoSheet(Todo(), context),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _apiService.getTodos(), // Get todos which returns a future
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Called when the future is resolved (i.e: when the result is returned from the server)
              List<Todo> todos = snapshot.data as List<Todo>;
              return _buildListView(todos);
            } else {
              return Center(
                child:
                    CircularProgressIndicator(), // Loading with the request is being processed
              );
            }
          },
        ),
      ),
    );
  }

// Build todos list
  Widget _buildListView(List<Todo> toDos) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: toDos.length,
        itemBuilder: (context, index) {
          Todo toDo = toDos[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(toDo.title,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    Text(
                      toDo.description,
                    ),
                    Text(toDo.status),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            _apiService.deleteTodo(toDo.id).then((_) {
                              setState(() {
                                // Here we call set state in order to rebuild the widget and get todos
                              });
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _openManageTodoSheet(toDo, context);
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// This method opens the modal bottom sheet which hosts the ManageTodoWidget which is responsible for editing or adding new Todos
  void _openManageTodoSheet(Todo toDo, BuildContext context) {
    toDo = toDo ?? new Todo();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: ManageTodoWidget(
            todo: toDo,
            saveChanges:
                _saveChanges, // We pass a reference tho the _saveChanges so we can call it from the child widget
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _saveChanges(Todo todo) {
    if (todo.id == 0) {
      // New Todo with id zero
      _apiService.addTodo(todo).then((_) {
        Navigator.of(context).pop(); // Close Modal Bottom sheet
        setState(
            () {}); // Calling set state to rebuild the UI and get fresh todo list
      });
    } else {
      _apiService.updateToDo(todo).then((_) {
        Navigator.of(context).pop(); // Close Modal Bottom sheet
        setState(
            () {}); // Calling set state to rebuild the UI and get fresh todo list
      });
    }
  }
}
