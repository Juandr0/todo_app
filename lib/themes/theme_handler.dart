import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/themes/bubbles.dart';
import 'package:todo_app/themes/backgrounds.dart';

enum BackgroundTheme {
  blueBubbles,
  orangeBubbles,
  space,
  particles,
}

class ThemeHandler extends StatelessWidget {
  const ThemeHandler({required this.theme, super.key});

  final BackgroundTheme? theme;
  @override
  Widget build(BuildContext context) {
    switch (theme) {
      case BackgroundTheme.blueBubbles:
        return const Bubbles(colors: BubbleColors.blue);

      case BackgroundTheme.orangeBubbles:
        return const Bubbles(colors: BubbleColors.orange);

      case BackgroundTheme.space:
        return Backgrounds(behaviour: SpaceBehaviour());

      case BackgroundTheme.particles:
        return Backgrounds(behaviour: RandomParticleBehaviour());

      default:
        return Backgrounds(behaviour: EmptyBehaviour());
    }
  }
}
