import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theming/theming_provider.dart';
class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return IconButton(
      icon: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(isDark),
          color: isDark ? Colors.amber : Colors.indigo,
        ),
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
      tooltip: isDark ? 'turn into light' : 'turn into dark',
    );
  }
}
