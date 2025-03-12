import 'package:flutter/material.dart';
import 'package:sae_mobile/src/utils/colors.dart';

class PickMenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PickMenuButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(PickMenuColors.buttonColor),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        )),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        )),
      ),
      child: Text(text)
    );
  }
}