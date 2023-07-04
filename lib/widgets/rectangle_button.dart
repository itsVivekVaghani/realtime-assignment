import 'package:assignment/utills/app_text_theme.dart';
import 'package:assignment/utills/constants.dart';
import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  const RectangleButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor, this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor ?? buttonBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextTheme.buttonTextTheme.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
