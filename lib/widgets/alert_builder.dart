import 'package:flutter/material.dart';
import 'package:todo_app/views/post_it_view.dart';

class AlertBuilder {
  static void buildPostIt(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.yellow,
        content: PostItView(backgroundColor: Colors.yellow),
        actions: <Widget>[
          Column(
            children: [
              Text('test'),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
