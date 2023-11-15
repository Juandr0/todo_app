import 'package:flutter/material.dart';
import 'package:todo_app/models/to_do.dart';
import 'package:todo_app/views/post_it_view.dart';

class AlertBuilder {
  static void buildPostIt(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        content: PostItView(
          todoItem: Todo(
              Image.network(
                width: double.infinity,
                fit: BoxFit.fitWidth,
                'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_07/2233721/171120-smile-stock-njs-333p.jpg',
              ),
              'descriptionjanne',
              title: 'Titeljanne'),
        ),
        actions: <Widget>[
          Row(
            children: [
              const Spacer(),
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
    );
  }
}
