import 'package:flutter/material.dart';
import 'package:todo_app/models/to_do.dart';
import 'package:todo_app/views/post_it_view.dart';

class AlertBuilder {
  static void buildPostIt(BuildContext context, Todo todo) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: PostItView(todoItem: todo),
                ),
              ),
            ));
  }
}
