import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildAppTheme();

  static ThemeData _buildAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );
  }
}
