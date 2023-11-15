import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print('Clicked on item');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: const Icon(
          Icons.check_box,
          color: darkGrey,
        ),
        title: const Text(
          'Check Mail',
          style: TextStyle(
            fontSize: 16,
            color: darkGrey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: deleteIcon,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 16,
              icon: const Icon(Icons.delete),
              onPressed: () {
                print('Clicked on delete icon');
              },
            )),
      ),
    );
  }
}
