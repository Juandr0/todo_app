import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class Todo {
  Todo({
    required this.title,
    this.description,
    this.image,
    this.done = false,
    this.backgroundColor = AppColors.defaultPostitBackground,
  });

  String title;
  String? description;
  Image? image;
  bool done = false;
  Color backgroundColor;

  static Todo createTodo() {
    return Todo(title: '');
  }
}
