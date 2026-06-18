import 'package:flutter/material.dart';

class AppColors {
  // TODO: テーマカラーは後で確定する
  static const Color deckBackground = Color(0xFF0D1117);
  static const Color deckText = Color(0xFFFFFFFF);

  static const Color blue = Color(0xFF5EC9F7);
  static const Color pink = Color(0xFFEF97B0);
  static const Color green = Color(0xFF4CAF50);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pink, blue],
  );
}
