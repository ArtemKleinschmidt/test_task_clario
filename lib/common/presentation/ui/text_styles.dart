import 'package:flutter/material.dart';

import 'colors.dart';

final class AppTextStyles {
  AppTextStyles._();

  static const inputError = TextStyle(
    color: AppColors.red,
    fontSize: 16,
  );

  static const inputSuccess = TextStyle(
    color: AppColors.green,
    fontSize: 16,
  );

  static const inputDefault = TextStyle(
    color: AppColors.darkViolet,
    fontSize: 16,
  );

  static const hintStyle = TextStyle(
    color: AppColors.blueGrey,
    fontSize: 16,
  );

  static const title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.darkViolet,
  );

  static const smallTextDefault = TextStyle(
    fontSize: 14,
    color: AppColors.darkViolet,
  );

  static const smallTextError = TextStyle(
    fontSize: 14,
    color: AppColors.red,
  );

  static const smallTextSuccess = TextStyle(
    fontSize: 14,
    color: AppColors.green70,
  );

  static const buttonText = TextStyle(
      color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold);
}
