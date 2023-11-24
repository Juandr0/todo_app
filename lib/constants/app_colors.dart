import 'package:flutter/material.dart';

enum PostItColors {
  red,
  orange,
  yellow,
  green,
  aqua,
  blue,
  deepblue,
  purple,
  pink,
  white
}

class AppColors {
  static const Color backGroundColor = Color(0xFFEEEFF5);
  static const Color defaultPostitBackground = Color.fromARGB(255, 255, 255, 0);
  static const Color darkGrey = Color(0xFF3A3A3A);
  static const Color postItSecondary = Color.fromARGB(187, 190, 190, 190);
  static const Color active = Colors.blue;
  static const Color inactive = Colors.grey;

  static const List<Color> paletteColors = [
    Color.fromARGB(255, 255, 90, 90),
    Color.fromARGB(255, 255, 150, 0),
    defaultPostitBackground,
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 73, 161, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 255, 255),
  ];

  static int getPaletteColorsLength() {
    return paletteColors.length;
  }

  static Color getPaletteColor(PostItColors postItColor) {
    switch (postItColor) {
      case PostItColors.red:
        return paletteColors[0];
      case PostItColors.orange:
        return paletteColors[1];
      case PostItColors.yellow:
        return paletteColors[2];
      case PostItColors.green:
        return paletteColors[3];
      case PostItColors.aqua:
        return paletteColors[4];
      case PostItColors.blue:
        return paletteColors[5];
      case PostItColors.purple:
        return paletteColors[6];
      case PostItColors.pink:
        return paletteColors[7];
      case PostItColors.white:
        return paletteColors[8];
      default:
        return defaultPostitBackground;
    }
  }
}
