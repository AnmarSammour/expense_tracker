import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    Key? key,
    required this.fill,
  }) : super(key: key);

  final double fill;

  @override
  Widget build(BuildContext context) {
    // Check if the device is in dark or light mode
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Ensures the element stretches to take up full space in the vertical direction
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill, // Sets the height of the bar as a fraction from 0 to 1
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              // Sets the color of the bar based on the theme mode (dark or light)
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
