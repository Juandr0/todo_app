import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class BubblesModel {
  BubblesModel({
    required this.backgroundColor,
    required this.bubbleColors,
    required this.bubbleSize,
    required this.amountOfBubbles,
  });

  final Color backgroundColor;
  final List<Color> bubbleColors;
  final double bubbleSize;
  final int amountOfBubbles;

  static BubblesModel blueBubbles = BubblesModel(
    backgroundColor: AppColors.blueBubblesBackground,
    bubbleColors: AppColors.blueBubbles,
    bubbleSize: 0.1,
    amountOfBubbles: 100,
  );

  static BubblesModel orangeBubbles = BubblesModel(
    backgroundColor: AppColors.orangeBubblesBackground,
    bubbleColors: AppColors.orangeBubbles,
    bubbleSize: 0.35,
    amountOfBubbles: 25,
  );
}
