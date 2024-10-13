import 'package:flutter/material.dart';

import '../colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
    this.text, {
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 240,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.blue1, AppColors.blue2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(text,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
