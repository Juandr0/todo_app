import 'package:flutter/material.dart';
import 'package:todo_app/models/to_do.dart';
import 'package:todo_app/views/post_it_view.dart';

class AlertBuilder {
  static void buildPostIt(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: PostItView(
              todoItem: Todo(
                  Image.network(
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_07/2233721/171120-smile-stock-njs-333p.jpg',
                  ),
                  'descriptionJanne',
                  title: 'TitelJanne'),
            ),
          ),
        ),
      ),
    );
  }
}
