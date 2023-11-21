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

  static List<Todo> todoList() {
    return [
      Todo(title: 'Buy coffee', done: false),
      Todo(
        title: 'Go to the gym',
        done: true,
        backgroundColor: AppColors.getPaletteColor(PostItColors.aqua),
      ),
      Todo(
        title: 'Win Hyrox race',
        done: false,
        backgroundColor: AppColors.getPaletteColor(PostItColors.pink),
        image: Image.asset('assets/hyrox_race.png'),
      )
    ];
  }
}
