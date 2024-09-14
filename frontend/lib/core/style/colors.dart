import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static AppColors? _instance;

  static AppColors get instance {
    _instance ??= AppColors._();
    return _instance!;
  }

  // Basic Colors
  static Color get black => const Color(0xFF0B0C12);
  static Color get white => const Color(0xFFFFFFFF);
}
