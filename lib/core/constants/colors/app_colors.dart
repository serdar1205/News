import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color cardColor = Color.fromRGBO(230, 230, 230, 1);
  static const Color gray = Color.fromRGBO(218, 210, 210, 0.7019607843137254);
  static const formBG = Color(0xFFEDEFF5);
  static const white = Colors.white;
  static const Color mainbuttonColor2 = Color.fromRGBO(71, 18, 155, 1);
  static const Color mainbuttonColor3 = Color.fromRGBO(101, 44, 191, 1.0);
}

class AvatarColorHelper {
  static final List<Color> _avatarColors = [
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF3F51B5), // Indigo
    Color(0xFF2196F3), // Blue
    Color(0xFF00BCD4), // Cyan
    Color(0xFF4CAF50), // Green
    Color(0xFFFFC107), // Amber
    Color(0xFFFF5722), // Deep Orange
  ];

  static Color getColor(String seed) {
    final int hash = seed.hashCode;
    return _avatarColors[hash % _avatarColors.length];
  }
}