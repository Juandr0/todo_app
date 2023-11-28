import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/bubbles_model.dart';

class Bubbles extends StatelessWidget {
  const Bubbles({required this.bubbles, super.key});
  final BubblesModel bubbles;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Container(color: bubbles.backgroundColor),
      ),
      Positioned.fill(
        child: FloatingBubbles.alwaysRepeating(
          noOfBubbles: bubbles.amountOfBubbles,
          colorsOfBubbles: bubbles.bubbleColors,
          sizeFactor: bubbles.bubbleSize,
          speed: BubbleSpeed.slow,
        ),
      ),
    ]);
  }
}
