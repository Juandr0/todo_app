import 'package:flutter/material.dart';

class Todo {
  Todo(this.image, this.description, {required this.title});

  final String title;
  final String? description;
  final Image? image;
  bool done = false;
}
