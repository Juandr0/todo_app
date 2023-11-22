
import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/models/to_do.dart';
import 'package:todo_app/views/post_it_view.dart';
import 'package:todo_app/widgets/checkmark.dart';

class AlertBuilder {
  static void buildPostIt(
      BuildContext context, Todo todo, Function(Todo) onTodoChanged) {
    Expanded textButton(String text, BuildContext context) {
      return Expanded(
        child: SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.postItSecondary,
            ),
            onPressed: () => {
              if (text == 'Save') {onTodoChanged(todo)},
              Navigator.pop(context, text),
            },
            child: Text(text),
          ),
        ),
      );
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Stack(children: [
                  PostItView(todoItem: todo),
                  CheckMark(done: todo.done),
                ]),
              ],
            ),
          ),
        ),
        actions: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textButton('Cancel', context),
                  const SizedBox(width: AppSizes.between),
                  textButton('Save', context)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
