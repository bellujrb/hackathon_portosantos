import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static AppTextStyles? _instance;

  static AppTextStyles get instance {
    _instance ??= AppTextStyles._();
    return _instance!;
  }

TextStyle get smallWhite => TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
}

extension AppTextStylesExtension on BuildContext {
  AppTextStyles get appTextStyles => AppTextStyles.instance;
}