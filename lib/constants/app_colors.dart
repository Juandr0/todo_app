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
  static const Color blueBubblesBackground = Color.fromARGB(255, 15, 94, 156);
  static const Color orangeBubblesBackground = Color.fromRGBO(255, 193, 0, 1);

  // animated bubbles themes
  static const List<Color> blueBubbles = [
    Color.fromARGB(255, 35, 137, 218),
    Color.fromARGB(255, 28, 163, 236),
    Color.fromARGB(255, 90, 188, 216),
    Color.fromARGB(255, 116, 204, 244)
  ];

  static const List<Color> orangeBubbles = [
    Color.fromRGBO(255, 193, 0, 1),
    Color.fromRGBO(255, 154, 0, 1),
    Color.fromRGBO(255, 116, 0, 1),
    Color.fromRGBO(255, 77, 0, 1),
    Color.fromRGBO(255, 0, 0, 1)
  ];

  // Palette colors section

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
