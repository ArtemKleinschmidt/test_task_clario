import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_task_clario/common/presentation/assets/drawable.dart';

import '../colors.dart';
import '../text_styles.dart';

class AppInputField extends StatefulWidget {
  const AppInputField(
      {super.key,
      this.showHideIcon = false,
      this.isError = false,
      this.isSuccess = false,
      this.focusNode,
      this.textEditingController,
      this.hintText});

  final bool showHideIcon;
  final bool isError;
  final bool isSuccess;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final String? hintText;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool _isTextVisible = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: _backgroundColor(widget.isError),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _borderColor(_focusNode,
              isError: widget.isError, isSuccess: widget.isSuccess),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextField(
              style: widget.isError
                  ? AppTextStyles.inputError
                  : widget.isSuccess
                      ? AppTextStyles.inputSuccess
                      : AppTextStyles.inputDefault,
              decoration: InputDecoration.collapsed(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.hintStyle,
              ),
              controller: widget.textEditingController,
              focusNode: _focusNode,
              obscureText: widget.showHideIcon && !_isTextVisible,
            ),
          ),
          if (widget.showHideIcon)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: _isTextVisible
                    ? SvgPicture.asset(
                        AppDrawable.icShowPassword,
                        colorFilter:
                            ColorFilter.mode(_iconColor, BlendMode.srcIn),
                      )
                    : SvgPicture.asset(
                        AppDrawable.icHidePassword,
                        colorFilter:
                            ColorFilter.mode(_iconColor, BlendMode.srcIn),
                      ),
                onPressed: () {
                  setState(() {
                    _isTextVisible = !_isTextVisible;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Color get _iconColor => widget.isError ? AppColors.red : AppColors.blueGrey;

  Color _borderColor(FocusNode focusNode,
      {required bool isError, required bool isSuccess}) {
    if (isError) {
      return AppColors.red;
    }
    if (isSuccess) {
      return AppColors.green;
    }

    return focusNode.hasFocus ? AppColors.blueGrey : AppColors.white;
  }

  _backgroundColor(bool isError) {
    return isError ? AppColors.pink : AppColors.white;
  }
}
