import 'package:flutter/material.dart';
import 'package:sae_mobile/src/utils/colors.dart';

class PickMenuTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String hintText;
  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: PickMenuColors.borderColor,
      width: 2.5,
    )
  );
  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: PickMenuColors.textFieldErrorBorder,
      width: 2.5,
    )
  );

  PickMenuTextField({
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: _border,
        focusedBorder: _border,
        enabledBorder: _border,
        disabledBorder: _border,
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder,
        fillColor: PickMenuColors.backgroundColor,
      )
    );
  }
}