import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/bubbles_model.dart';
import 'package:todo_app/themes/bubbles.dart';
import 'package:todo_app/themes/backgrounds.dart';

enum BackgroundTheme {
  blueBubbles,
  orangeBubbles,
  space,
  particles,
  disabled,
}

class ThemeHandler extends StatelessWidget {
  const ThemeHandler({required this.theme, super.key});
  final BackgroundTheme? theme;

  @override
  Widget build(BuildContext context) {
    switch (theme) {
      case BackgroundTheme.blueBubbles:
        return Bubbles(bubbles: BubblesModel.blueBubbles, key: UniqueKey());

      case BackgroundTheme.orangeBubbles:
        return Bubbles(bubbles: BubblesModel.orangeBubbles, key: UniqueKey());

      case BackgroundTheme.space:
        return Backgrounds(behaviour: SpaceBehaviour());

      case BackgroundTheme.particles:
        return Backgrounds(behaviour: RandomParticleBehaviour());

      default:
        return Backgrounds(behaviour: EmptyBehaviour());
    }
  }
}
