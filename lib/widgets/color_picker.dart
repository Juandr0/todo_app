import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker(this.initialBackgroundColor,
      {required this.changeBackground, super.key});

  final Function(Color) changeBackground;
  final Color? initialBackgroundColor;

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color currentColor;
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
  void initState() {
    super.initState();
    if (widget.initialBackgroundColor != null) {
      currentColor = widget.initialBackgroundColor!;
    } else {
      currentColor = colors[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
      ),
    );
  }

  Container colorContainer(Color color) {
    bool highLightColor = currentColor == color;

    return Container(
      decoration: highLightColor
          ? BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: AppSizes.inlineText,
              ),
            )
          : null,
      child: InkWell(
        onTap: () {
          setState(() {
            currentColor = color;
          });
          widget.changeBackground(color);
        },
        child: Container(
          width: AppSizes.between,
          height: AppSizes.between,
          decoration: BoxDecoration(color: color),
        ),
      ),
    );
  }
}
