import 'package:flutter/material.dart';

class Todo {
  Todo({required this.title, this.description, this.image, this.done = false});

  String title;
  String? description;
  Image? image;
  bool done = false;

  static List<Todo> todoList() {
    return [
      Todo(title: 'Buy coffee', done: false),
      Todo(title: 'Go to the gym', done: true)
    ];
  }
}
