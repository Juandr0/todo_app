import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_sizes.dart';

class CheckMark extends StatelessWidget {
  const CheckMark({super.key, required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.inline),
      child: Visibility(
        visible: done,
        child: const Row(
          children: [
            Spacer(),
            Icon(
              Icons.check_circle_outline_sharp,
              color: AppColors.darkGrey,
              size: AppSizes.between * 2,
            ),
          ],
        ),
      ),
    );
  }
}
