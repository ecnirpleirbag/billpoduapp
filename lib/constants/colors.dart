import 'package:flutter/material.dart';

class AppColors {
  static Color kPrimaryColor = const Color(0xFF4fc1b3);
  static Color kSecondaryColor = const Color(0xFFf3f5f5);
  static Color kPrimaryLight = const Color.fromARGB(255, 142, 221, 211);
  static Color kPrimaryDark = const Color(0xFF1f302d);
  static Color red = const Color(0xFFf2535b);
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
