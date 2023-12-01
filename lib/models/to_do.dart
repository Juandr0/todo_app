import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class Todo {
  Todo({
    required this.title,
    this.documentId,
    this.description,
    this.image,
    this.imageUrl,
    this.done = false,
    this.backgroundColor = AppColors.defaultPostitBackground,
  });

  String? documentId;
  String title;
  String? description;
  File? image;
  bool done = false;
  Color backgroundColor;
  String? imageUrl;

  static Todo createTodo() {
    return Todo(title: '');
  }
}
