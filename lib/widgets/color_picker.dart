import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker({required this.changeBackground, super.key});

  final Function(Color) changeBackground;

  final List<Color> colors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 150, 0),
    const Color.fromARGB(255, 255, 255, 0),
    const Color.fromARGB(255, 0, 255, 0),
    const Color.fromARGB(255, 0, 255, 255),
    const Color.fromARGB(255, 0, 123, 255),
    const Color.fromARGB(255, 115, 0, 255),
    const Color.fromARGB(255, 255, 0, 255),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(188, 136, 136, 136),
      ),
      padding: const EdgeInsets.all(AppSizes.within),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          colors.length,
          (index) {
            return colorContainer(colors[index]);
          },
        ),
      ),
    );
  }

  InkWell colorContainer(Color color) {
    return InkWell(
      onTap: () {
        changeBackground(color);
      },
      child: Container(
        width: AppSizes.between,
        height: AppSizes.between,
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}
