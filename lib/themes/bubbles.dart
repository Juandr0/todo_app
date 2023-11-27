import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class Bubbles extends StatelessWidget {
  const Bubbles({super.key});

  final double bubbleSize = 0.1;
  final int bubblesAmount = 100;

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
          noOfBubbles: bubblesAmount,
          colorsOfBubbles: AppColors.bubbles,
          sizeFactor: bubbleSize,
          speed: BubbleSpeed.slow,
        ),
      ),
    ]);
  }
}
