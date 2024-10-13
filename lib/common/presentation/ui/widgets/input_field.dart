import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      this.showHideIcon = false,
      this.isError = false,
      this.isSuccess = false,
      this.focusNode,
      this.textEditingController});

  final bool showHideIcon;
  final bool isError;
  final bool isSuccess;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
        borderRadius: BorderRadius.circular(8),
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
              controller: widget.textEditingController,
              focusNode: _focusNode,
              decoration: null,
              obscureText: widget.showHideIcon && !_isTextVisible,
            ),
          ),
          if (widget.showHideIcon)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  _isTextVisible ? Icons.visibility : Icons.visibility_off,
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

  Color _borderColor(FocusNode focusNode,
      {required bool isError, required bool isSuccess}) {
    if (isError) {
      return const Color(0xFFE53935);
    }
    if (isSuccess) {
      return const Color(0xFF2E7D32);
    }

    return focusNode.hasFocus
        ? const Color(0xFF000000)
        : const Color(0xFFBBDEFB);
  }
}
