import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key, required this.id, required this.data});

  final String id;
  final String data;

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final _dataController = TextEditingController();

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dataController.text = widget.data;
  }

  Future<void> updateTodoItemRequest() async {
    const apiUrl = "http://localhost:3000/update";

    var response = await http.put(
                  Uri.parse(apiUrl),
                  headers: { "Content-Type" : "application/json"},
                  body: jsonEncode({
                    "id": widget.id,
                    "data": _dataController.text
                  })
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Todo item is updated")));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error occured while updating")));
      }
    }

    if (context.mounted) {
      Navigator.pop(context);
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
          Row(
            children: [
            ElevatedButton(onPressed: updateTodoItemRequest, child: const Text("Update Todo Item")), 
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