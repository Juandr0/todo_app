import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

enum BubbleColors { blue, orange }

class Bubbles extends StatelessWidget {
  const Bubbles({required this.colors, super.key});

  final BubbleColors colors;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    List<Color> bubbleColors;
    double bubbleSize = 0.1;
    int bubblesAmount = 100;

    switch (colors) {
      case BubbleColors.blue:
        backgroundColor = AppColors.blueBubblesBackground;
        bubbleColors = AppColors.blueBubbles;
        break;
      case BubbleColors.orange:
        backgroundColor = AppColors.orangeBubblesBackground;
        bubbleColors = AppColors.orangeBubbles;
        bubbleSize = 0.35;
        bubblesAmount = 25;
        break;
    }

    return Stack(children: [
      Positioned.fill(
        child: Container(color: backgroundColor),
      ),
      Positioned.fill(
        child: FloatingBubbles.alwaysRepeating(
          noOfBubbles: bubblesAmount,
          colorsOfBubbles: bubbleColors,
          sizeFactor: bubbleSize,
          speed: BubbleSpeed.slow,
        ),
      ),
    ]);
  }
}
