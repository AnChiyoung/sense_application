import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final Color backgroundColor;
  final Color textColor;
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final VoidCallback? onPressed;
  final FontWeight? fontWeight;

  const CustomButton(
      {super.key,
      this.height = 40,
      this.fontWeight,
      required this.backgroundColor,
      required this.textColor,
      required this.labelText,
      this.onPressed,
      this.borderRadius,
      this.prefixIcon,
      this.suffixIcon,
      this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text(
                  labelText,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: fontWeight ?? FontWeight.w700,
                  ),
                )),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
      ),
    );
  }
}
