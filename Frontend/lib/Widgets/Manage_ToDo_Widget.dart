import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Service/apiservice.dart';
import 'package:todoapp/models/todo.dart';

class ManageTodoWidget extends StatefulWidget {
  Todo todo = Todo();
  final Function saveChanges;
  ManageTodoWidget({required this.todo, required this.saveChanges});

  @override
  _ManageTodoWidgetState createState() => _ManageTodoWidgetState();
}

class _ManageTodoWidgetState extends State<ManageTodoWidget> {
  ApiService _apiService = ApiService();

  final _form = GlobalKey<FormState>();
  TextEditingController _titleETC = TextEditingController();
  TextEditingController _descETC = TextEditingController();
  TextEditingController _statETC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    initialValue: widget.todo.title,
                    onSaved: (value) {
                      widget.todo.title = value as String;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.todo.description,
                    onSaved: (value) {
                      widget.todo.description = value as String;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.todo.status,
                    onSaved: (value) {
                      widget.todo.status = value as String;
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        _form.currentState!
                            .save(); // we call the save method in order to invoke the onsaved method on form fields
                        this.widget.saveChanges(widget.todo);
                      },
                      child: Icon(Icons.check)),
                ],
              ))),
    );
  }
}
