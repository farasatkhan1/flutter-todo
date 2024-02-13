import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/todo.dart';

import 'package:frontend/views/create.dart';
import 'package:frontend/views/todo_item.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoScreen());
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> _todo = [];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      final List<dynamic> json = decodedJson['getAllTodoItems'];

      setState(() {
        _todo = json.map((item) => Todo.fromJson(item)).toList();
      });
    } else {
      throw Exception("Failed to load todo items");
    }
  }

  FutureOr onGoBack(dynamic value) {
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Items"),
      ),
      body: Column(
        children: [
        Expanded(child: ListView.builder(
        itemCount: _todo.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TodoItem(todoItem: _todo[index]))).then(onGoBack);
            }, child:Text(_todo[index].data, style: const TextStyle(color: Colors.black),)),
          );
        },
      )),
      ElevatedButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTodo())).then(onGoBack);
      }, child: const Text("Create new item")),
      const SizedBox(height: 30,)
      ],),
    );
  }

}