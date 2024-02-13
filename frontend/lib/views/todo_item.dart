import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/todo.dart';
import 'package:frontend/views/update.dart';

import 'package:http/http.dart' as http;

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todoItem});

  final Todo todoItem;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {

  Future<void> _deleteTodoItem() async {
    const apiUrl = "http://localhost:3000/delete";

    var response = await http.delete(
                  Uri.parse(apiUrl),
                  headers: { "Content-Type" : "application/json"},
                  body: jsonEncode({"id": widget.todoItem.id})
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item is removed")));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error occured while removing item")));
      }
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(children: [
        Text(widget.todoItem.data),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTodo(id: widget.todoItem.id, data: widget.todoItem.data)));
        }, child: const Text("Update Todo Item")),
        ElevatedButton(onPressed: _deleteTodoItem, child: const Text("Delete Item"))],),
    ),);
  }
}