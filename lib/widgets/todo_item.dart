import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/widgets/alert_builder.dart';
import '../models/to_do.dart';

class ToDoItem extends StatefulWidget {
  ToDoItem({super.key, required this.todo, required this.onTodoChanged});
  final Todo todo;
  final Function onTodoChanged;

  @override
  createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.todo.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          AlertBuilder.buildPostIt(context, widget.todo, (onTodoChanged) {
            setState(() {
              widget.onTodoChanged(widget.todo);
            });
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Checkbox(
          value: widget.todo.done,
          onChanged: (bool? value) {
            setState(() {
              widget.todo.done = !widget.todo.done;
            });
            widget.onTodoChanged(widget.todo);
          },
          activeColor: AppColors.darkGrey,
        ),
        title: Text(
          widget.todo.title,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.darkGrey,
            decoration: widget.todo.done ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
