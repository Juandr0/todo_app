import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

class Backgrounds extends StatefulWidget {
  const Backgrounds({super.key, required this.behaviour});
  final Behaviour behaviour;

  @override
  State createState() => _BackgroundsState();
}

class _BackgroundsState extends State<Backgrounds>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: widget.behaviour,
      vsync: this,
      child: const SizedBox.shrink(),
    );
  }
}
