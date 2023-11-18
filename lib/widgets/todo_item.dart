import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/alert_builder.dart';
import '../models/to_do.dart';

class ToDoItem extends StatelessWidget {
  final Todo todo;
  final Function onTodoChanged;

  const ToDoItem({Key? key, required this.todo, required this.onTodoChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          AlertBuilder.buildPostIt(context, todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Checkbox(
          value: todo.done,
          onChanged: (bool? value) {
            onTodoChanged(todo);
          },
          activeColor: darkGrey,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            color: darkGrey,
            decoration: todo.done ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
