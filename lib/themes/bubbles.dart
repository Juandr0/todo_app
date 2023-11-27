import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class Bubbles extends StatelessWidget {
  const Bubbles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Container(
          color: AppColors.bubblesBackground,
        ),
      ),
      Positioned.fill(
        child: FloatingBubbles.alwaysRepeating(
          noOfBubbles: 30,
          colorsOfBubbles: AppColors.bubbles,
          sizeFactor: 0.2,
          speed: BubbleSpeed.slow,
        ),
      ),
    ]);
  }
}
