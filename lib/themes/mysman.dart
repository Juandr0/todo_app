import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';

class Mysman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
          side: BorderSide(
            color: Color.fromARGB(255, 146, 199, 246).withOpacity(1),
            width: 4,
          ),
        ),
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: Image.asset('assets/themes/mysman.png'),
        ),
      ),
    );
  }
}
