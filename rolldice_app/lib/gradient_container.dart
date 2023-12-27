import 'package:flutter/material.dart';
import 'package:rolldice_app/dice_roller.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> colors;

  const GradientContainer({super.key, required this.colors});

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
