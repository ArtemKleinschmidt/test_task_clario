import 'package:flutter/material.dart';
import 'package:test_task_clario/common/presentation/ui/text_styles.dart';

import '../colors.dart';

const _borderRadius = BorderRadius.all(Radius.circular(30));

class AppButton extends StatelessWidget {
  const AppButton(
    this.text, {
    super.key,
    this.onTap,
    this.height = 48,
    this.width = 240,
  });

  final VoidCallback? onTap;
  final String text;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blue1, AppColors.blue2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: _borderRadius,
      ),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: _borderRadius,
              onTap: onTap,
              child: Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  child: Text(text, style: AppTextStyles.buttonText)))),
    );
  }
}
