import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static AppTextStyles? _instance;

  static AppTextStyles get instance {
    _instance ??= AppTextStyles._();
    return _instance!;
  }

TextStyle get bigBlack => TextStyle(
      color: AppColors.black,
      fontSize: 40,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.none);

TextStyle get mediumBlack => TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

TextStyle get smallGrey => TextStyle(
      color: Colors.grey.withOpacity(0.7),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

}

extension AppTextStylesExtension on BuildContext {
  AppTextStyles get appTextStyles => AppTextStyles.instance;
}