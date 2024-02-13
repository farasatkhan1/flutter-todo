import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodo();
}

class _CreateTodo extends State<CreateTodo> {
  final _dataController = TextEditingController();

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  Future<void> createTodoItemRequest() async {
    const apiUrl = "http://localhost:3000/create";

    var response = await http.post(Uri.parse(apiUrl), 
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            "data": _dataController.text
                          }));

    if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Todo item is created")));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error occured while creating todo item")));
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
        children: [
          TextField(
            controller: _dataController,
            decoration: const InputDecoration(hintText: "Enter Todo Item"),
          ),
          const SizedBox(height: 10),
          Row(children: [
            ElevatedButton(onPressed: createTodoItemRequest, child: const Text("Create")), 
            const SizedBox(width: 20),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("Go to Home"))
            ],)
        ],
      ),
      )
    );
  }
}