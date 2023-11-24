import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/constants/app_colors.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.initialBackgroundColor != null) {
      currentColor = widget.initialBackgroundColor!;
    } else {
      currentColor = AppColors.defaultPostitBackground;
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
            AppColors.getPaletteColorsLength(),
            (index) {
              return colorContainer(AppColors.paletteColors[index]);
            },
          ),
        ),
      ),
    );
  }

  Container colorContainer(Color color) {
    bool isHighlighted = currentColor == color;
    Color highlightColor = const Color.fromARGB(255, 233, 233, 233);

    return Container(
      decoration: isHighlighted
          ? BoxDecoration(
              border: Border.all(
                color: highlightColor,
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
