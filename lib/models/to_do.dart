import 'package:flutter/material.dart';

class Todo {
  Todo(this.image, this.description, {required this.title});

  String title;
  String? description;
  Image? image;
  bool done = false;
}
